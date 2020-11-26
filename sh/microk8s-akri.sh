#!/bin/bash

set -e
trap 'catch $? $LINENO' EXIT
catch() {
  if [ "$1" != "0" ]; then
    echo "Error $1 occurred on line $2"
    #delete_gce_instance $AKRI_INSTANCE
  fi
}

REPORT='report.md'
touch "$REPORT"

OS=$(uname -a)
echo "$OS"
if [[ "$OS" == 'Linux'* ]]
then
   lsb_release -a
fi

TOTAL_STEPS=2
SCRIPT_COMPLETED='<-<script-completed>->'
STEP_COMPLETED='<-<step-completed>->'

ON_GCE=$((curl -s -i metadata.google.internal | grep 'Google') || true)

echo -e " "
# variables below can be inherited from environment
if [[ -z ${GCP_PROJECT+x} && ! "$ON_GCE" == *'Google'* ]]    ; then echo "ERROR: gcp project not set" && false ; fi
if [[ -z ${GCP_ZONE+x} ]]                                    ; then GCP_ZONE='us-central1-c'                   ; fi ; echo "gcp zone: $GCP_ZONE"
if [[ -z ${AKRI_GCE_DELETE+x} ]]                             ; then AKRI_GCE_DELETE='false'                    ; fi ; echo "akri gce delete: $AKRI_GCE_DELETE"

if [[ -z ${MK8S_VERSION+x} ]]                                ; then MK8S_VERSION='1.19/stable'                 ; fi ; echo "microk8s version: $MK8S_VERSION"

if [[ -z ${AKRI_INSTALL+x} ]]                                ; then AKRI_INSTALL='true'                        ; fi ; echo "akri install: $AKRI_INSTALL"
if [[ -z ${VIDEO_INSTALL+x} ]]                               ; then VIDEO_INSTALL='true'                       ; fi ; echo "video install: $VIDEO_INSTALL"

if [[ -z ${AKRI_IMAGE_FAMILY+x} ]]                           ; then AKRI_IMAGE_FAMILY='ubuntu-2004-lts'        ; fi ; echo "akri image family: $AKRI_IMAGE_FAMILY"
if [[ -z ${AKRI_IMAGE_PROJECT+x} ]]                          ; then AKRI_IMAGE_PROJECT='ubuntu-os-cloud'       ; fi ; echo "akri image project: $AKRI_IMAGE_PROJECT"
if [[ -z ${AKRI_INSTANCE+x} ]]                               ; then AKRI_INSTANCE='microk8s-akri'              ; fi ; echo "akri host instance: $AKRI_INSTANCE"

echo -e " "

create_gce_instance() 
{
  local GCE_INSTANCE="$1"
  local GCE_IMAGE_FAMILY="$2"
  local GCE_IMAGE_PROJECT="$3"
  GCE_IMAGE=$(gcloud compute images describe-from-family "$GCE_IMAGE_FAMILY"  --project="$GCE_IMAGE_PROJECT" --format="value(name)")
  echo -e "\n### setup instance: $GCE_INSTANCE - image: $GCE_IMAGE - image family: $GCE_IMAGE_FAMILY - image project: $GCE_IMAGE_PROJECT"
  if [[ ! $(gcloud compute instances list --project="$GCP_PROJECT") == *"$GCE_INSTANCE"* ]]
  then 
    gcloud compute instances create \
        --machine-type='n1-standard-4' \
        --image-project="$GCE_IMAGE_PROJECT" \
        --image="$GCE_IMAGE" \
        --zone="$GCP_ZONE" \
        --project="$GCP_PROJECT" \
        "$GCE_INSTANCE"
  fi
  gcloud compute instances list --project="$GCP_PROJECT" | tee "$REPORT"
  while [[ ! $(gcloud compute ssh "$GCE_INSTANCE" --command='uname -a' --zone="$GCP_ZONE" --project="$GCP_PROJECT") == *'Linux'* ]]
  do
    echo -e "instance not ready for ssh..."
    sleep 5s
  done
  gcloud compute ssh "$GCE_INSTANCE" \
      --command='uname -a'  \
      --zone="$GCP_ZONE" \
      --project="$GCP_PROJECT"
}

delete_gce_instance()
{

  local GCE_INSTANCE="$1"
  echo -e "\n### delete gce instance: $GCE_INSTANCE"
  gcloud compute instances delete \
      --zone "$GCP_ZONE" \
      --project="$GCP_PROJECT" \
      --quiet \
      "$GCE_INSTANCE" 

}


if [[ ! "$ON_GCE" == *'Google'* ]]
then

  echo -e "\n### not on GCE\n"
  
  create_gce_instance "$AKRI_INSTANCE" "$AKRI_IMAGE_FAMILY" "$AKRI_IMAGE_PROJECT" 
      
  gcloud compute ssh "$AKRI_INSTANCE" --command='sudo rm -rf /var/lib/apt/lists/* && sudo apt update -y && (sudo apt upgrade -y || sudo apt upgrade -y) && sudo apt autoremove -y' --zone "$GCP_ZONE" --project="$GCP_PROJECT"
  gcloud compute scp "$0"  "$AKRI_INSTANCE:$(basename $0)" --zone "$GCP_ZONE" --project="$GCP_PROJECT"
  gcloud compute ssh "$AKRI_INSTANCE" --command="sudo chmod ugo+x ./$(basename $0)" --zone "$GCP_ZONE" --project="$GCP_PROJECT"
  
  I=0
  STEP=1
  STEP_REPORT="$AKRI_INSTANCE-step-report-$STEP.log" && (rm "$STEP_REPORT" || true) && touch "$STEP_REPORT"
  while [[ ! $(cat "$STEP_REPORT" | grep "$SCRIPT_COMPLETED") && $I -lt 5 ]]
  do
    I=$((I+1))
    echo -e "\n### executing script step: $STEP  - iteration: $I"
    gcloud compute ssh "$AKRI_INSTANCE" --command="bash ./$(basename $0) $STEP" --zone="$GCP_ZONE" --project="$GCP_PROJECT" | tee -a "$STEP_REPORT"
    if [[ $? == '0' ]] 
    then
      if [[ $(cat "$STEP_REPORT" | grep "$STEP_COMPLETED $STEP") ]]
      then
        if [[ "$STEP" -lt "$TOTAL_STEPS" ]]
        then
          STEP=$((STEP+1))
          STEP_REPORT="$AKRI_INSTANCE-step-report-$STEP.log" && (rm "$STEP_REPORT" || true)  && touch "$STEP_REPORT"
        fi
      fi
    fi
    while [[ ! $(gcloud compute ssh "$AKRI_INSTANCE" --command='uname -a' --zone="$GCP_ZONE" --project="$GCP_PROJECT") == *'Linux'* ]]
    do
      echo -e "instance not ready for ssh..."
      sleep 5s 
    done
  done
  cat "$STEP_REPORT" | grep "$SCRIPT_COMPLETED"
  rm  "$AKRI_INSTANCE-step-report-*" || true
  
  #generate report when on Github
  if [[ ! -z "$GITHUB_WORKFLOW" ]]
  then
    echo -e "### generating execution report..."
    gcloud compute scp $AKRI_INSTANCE:$REPORT $REPORT --zone $GCP_ZONE --project=$GCP_PROJECT
    cat README.template.md > README.md
    
    
    echo '## Execution Report' >> README.md
    echo '```' >> README.md
    cat $REPORT >> README.md
    echo '```' >> README.md
    
    helm repo add 'akri-helm-charts' 'https://deislabs.github.io/akri/'
    helm version | tee akri-helm-chart.md
    helm template --debug 'akri-helm-charts/akri-dev' | tee -a akri-helm-chart.md
    
    echo '## Akri Helm Chart' >> README.md
    echo '```' >> README.md
    echo -e "### generation date: $(date --utc)" >> README.md
    echo -e " " >> README.md
    cat akri-helm-chart.md >> README.md
    echo '```' >> README.md
  fi
      
  if [[ "$AKRI_GCE_DELETE" == 'true' ]]
  then
    echo "delete_gce_instance $AKRI_INSTANCE"
  fi
  
  exit 0
  
fi

#gcloud compute ssh microk8s-akri --zone 'us-central1-c' --project=$GCP_PROJECT

echo -e "\n### running on GCE\n"

cd
[[ -d '.kube' ]] || mkdir '.kube' 
sudo chown -f -R "$USER" '.kube' 
KUBE_CONFIG="$HOME/.kube/config"
[[ -f "$KUBE_CONFIG" ]] || touch "$KUBE_CONFIG"
chmod go-r "$KUBE_CONFIG"

exec_step1()
{

  local STEP="$1"
  
  echo -e "\n### STEP 1: INSTALL PACKAGES & SETUP MICROK8S:"
  
  if [[ -z $(which crictl) ]]
  then
    echo -e "\n### installing crictl: "
    VERSION="v1.17.0"
    TAR="crictl-${VERSION}-linux-amd64.tar.gz"
    curl -L "https://github.com/kubernetes-sigs/cri-tools/releases/download/$VERSION/$TAR" --output "$TAR"
    sudo tar zxvf "$TAR" -C /usr/local/bin
    rm -f "$TAR"
    echo -e "#### crictl path: $(which crictl)"
  fi

  if [[ "$VIDEO_INSTALL" == 'true' ]]
  then
  
    if [[ ! -f v4l2loopback-dkms_0.12.5-1_all.deb ]]
    then 
      echo -e "\n### build kernel module v4l2loopback: " | tee -a "$REPORT"
      #v0.12.5 is imperative (gstreamer will fail if lower) - 0.12.5 starts with Ubuntu 20.10 or newer
      sudo apt update -y && sudo apt install -y dkms
      sudo apt install -y "linux-modules-extra-$(uname -r)"
      curl http://deb.debian.org/debian/pool/main/v/v4l2loopback/v4l2loopback-dkms_0.12.5-1_all.deb -o v4l2loopback-dkms_0.12.5-1_all.deb
      sudo dpkg -i v4l2loopback-dkms_0.12.5-1_all.deb | tee -a "$REPORT"
      
    fi
    
    echo -e "\n### load kernel module v4l2loopback: " | tee -a "$REPORT"
    sudo modprobe v4l2loopback exclusive_caps=1 devices=2 video_nr=1,2 | tee -a "$REPORT"
   
    echo -e "\n### check required kernel modules: " | tee -a "$REPORT"
    lsmod | grep 'videodev' | tee -a "$REPORT"
    lsmod | grep 'v4l2loopback' | tee -a "$REPORT"
    modinfo 'v4l2loopback'| grep 'vermagic' | tee -a "$REPORT"
  
    echo -e "\n### check devices: " | tee -a "$REPORT"
    ls -l /dev/video1 | tee -a "$REPORT"
    ls -l /dev/video2 | tee -a "$REPORT"
    
    if [[ -z $(which gst-launch-1.0) ]]
    then
      sudo apt-get install -y \
           libgstreamer1.0-0 gstreamer1.0-tools gstreamer1.0-plugins-base \
           gstreamer1.0-plugins-good gstreamer1.0-libav
      echo -e "gst-launch path: $(which gst-launch-1.0)"
      gst-launch-1.0 --version
    fi
    
  fi
  
  if [[ -z $(which microk8s) ]]
  then
    echo -e "\n### install microk8s: "
    sudo snap install 'microk8s' --classic --channel="$MK8S_VERSION"
    sudo snap list | grep 'microk8s'
    sudo microk8s status --wait-ready
    sudo usermod -a -G 'microk8s' "$USER"
    echo -e "groups for user: $(groups)"
  fi
  
  echo -e "$STEP_COMPLETED $STEP"
  
  if [[ -f /var/run/reboot-required ]]
  then
    echo 'WARNING: reboot required. Reboot in 2s...'
    nohup sudo -b bash -c 'sleep 2s; reboot' &
  fi
  
  exit

}

exec_step2()
{
  local STEP="$1"
  
  echo -e "\n### STEP 2: RUN TESTS WITH AKRI:"
  
  echo -e "\n### reload v4l2loopback and create devices: "
  sudo modprobe v4l2loopback exclusive_caps=1 devices=2 video_nr=1,2
  
  echo -e "\n### check microk8s authorization: "
  groups | grep 'microk8s'
  
  echo -e "\n### check video devices: "
  ls -l /dev/video1
  ls -l /dev/video2

  if [[ -z $(sudo ps -ea | grep 'gst-launch') ]]
  then
  	echo -e "\n### start video streams (in background): " | tee -a "$REPORT"
  	(sudo nohup gst-launch-1.0 -v videotestsrc pattern=ball ! "video/x-raw,width=640,height=480,framerate=10/1" ! avenc_mjpeg ! v4l2sink device=/dev/video1 | tee -a "$REPORT") >> nohup.out 2>> nohup.err < /dev/null &
    (sudo nohup gst-launch-1.0 -v videotestsrc pattern=smpte horizontal-speed=1 ! "video/x-raw,width=640,height=480,framerate=10/1" ! avenc_mjpeg ! v4l2sink device=/dev/video2 | tee -a "$REPORT") >> nohup.out 2>> nohup.err < /dev/null &
    sleep 15s
  fi
  
  ls -l "$KUBE_CONFIG"
  microk8s config > "$KUBE_CONFIG"
  echo -e "\n### microk8s kube-config:"
  cat "$KUBE_CONFIG"
  
  if [[ -z $(sudo cat /var/snap/microk8s/current/args/kube-apiserver | grep -- '--allow-privileged=true') ]]
  then
     echo -e "\n### allowing privileged containers (required): "
     microk8s stop
     sudo echo '--allow-privileged=true' | sudo tee -a /var/snap/microk8s/current/args/kube-apiserver
     cat /var/snap/microk8s/current/args/kube-apiserver
     cat /var/snap/microk8s/current/args/kube-apiserver | grep -- '--allow-privileged=true'
   
     echo -e "\n### restarting microk8s: "
     microk8s start
     echo -e "\n### wait for cluster ready: "
     microk8s status --wait-ready
     microk8s status | grep 'microk8s is running'
  fi
  
  echo -e "\n### enabling microk8s addons: " | tee -a "$REPORT"
  microk8s enable dns | tee -a "$REPORT"
  microk8s enable helm3 | tee -a "$REPORT"
  microk8s enable rbac | tee -a "$REPORT"
  microk8s enable dashboard | tee -a "$REPORT"
  microk8s status --wait-ready
  
  sleep 60s
  
  if [[ "$AKRI_INSTALL" == 'true' ]]
  then 
  
    echo -e "\n### checking crictl: "
    which crictl | grep '/usr/local/bin/crictl'
    echo -e "check microk8s containerd socket:"
    ls -l /var/snap/microk8s/common/run/containerd.sock || true
    ls -l /var/snap/microk8s/common/run/containerd.sock  | awk '{print $1}' | grep 'srw' || true
  
    echo -e "\n### install akri chart: " | tee -a "$REPORT"
    (microk8s helm3 repo list | grep 'akri-helm-charts' || microk8s helm3 repo add 'akri-helm-charts' 'https://deislabs.github.io/akri/') | tee -a "$REPORT"
    
    AKRI_HELM_CRICTL_CONFIGURATION="--set agent.host.crictl=/usr/local/bin/crictl --set agent.host.dockerShimSock=/var/snap/microk8s/common/run/containerd.sock"
                                                      
    microk8s helm3 install 'akri'  \
        'akri-helm-charts/akri-dev' \
        $AKRI_HELM_CRICTL_CONFIGURATION \
        --set useLatestContainers=true \
        --set udev.enabled=true \
        --set udev.name=akri-udev-video \
        --set udev.udevRules[0]='KERNEL=="video[0-9]*"' \
        --set udev.brokerPod.image.repository='ghcr.io/deislabs/akri/udev-video-broker:latest-dev' | tee -a "$REPORT"
        
    sleep 60s
    
    echo -e "\n### waiting for installed chart to get ready: " | tee -a "$REPORT"
    microk8s kubectl wait --for=condition=available --timeout=300s 'deployment.apps/akri-controller-deployment' -n default | tee -a "$REPORT"
    
    echo -e "\n### get akri configuration: " | tee -a "$REPORT"
    microk8s kubectl get -o wide akric | tee -a "$REPORT"
    
    echo -e "\n### install video streaming app: " | tee -a "$REPORT"
    microk8s kubectl apply -f "https://raw.githubusercontent.com/deislabs/akri/main/deployment/samples/akri-video-streaming-app.yaml" | tee -a "$REPORT"
    microk8s kubectl wait --for=condition=available --timeout=300s 'deployment.apps/akri-video-streaming-app' -n default | tee -a "$REPORT"
    
    echo -e "\n### get pods --all-namespaces: " | tee -a "$REPORT"
    microk8s kubectl get -o wide pods --all-namespaces | tee -a "$REPORT"
    echo -e "\n### get daemonsets --all-namespaces: " | tee -a "$REPORT"
    microk8s kubectl get -o wide daemonsets --all-namespaces | tee -a "$REPORT"
    echo -e "\n### get services --all-namespaces: " | tee -a "$REPORT"
    microk8s kubectl get -o wide services --all-namespaces | tee -a "$REPORT"
   
    echo -e " "
    AKRI_DASHBOARD_PORT=$(microk8s kubectl get service/akri-video-streaming-app --output=jsonpath='{.spec.ports[0].port}')
    LOCAL_AKRI_DASHBOARD_PORT=12321
    echo -e "Akri dashboard ports - gce:  $AKRI_DASHBOARD_PORT - local: $LOCAL_AKRI_DASHBOARD_PORT " | tee -a "$REPORT"
    (nohup microk8s kubectl port-forward -n 'default' 'service/akri-video-streaming-app' "$LOCAL_AKRI_DASHBOARD_PORT:$AKRI_DASHBOARD_PORT" | tee -a "$REPORT") >> nohup.out 2>> nohup.err < /dev/null &
    
    K8S_DASHBOARD_PORT=$(microk8s kubectl get -n kube-system service/kubernetes-dashboard --output=jsonpath='{.spec.ports[0].port}')
    LOCAL_K8S_DASHBOARD_PORT=3443
    echo -e "K8s dashboard ports - gce:  $K8S_DASHBOARD_PORT - local: $LOCAL_K8S_DASHBOARD_PORT " | tee -a "$REPORT"
    (nohup microk8s kubectl port-forward -n 'kube-system' 'service/kubernetes-dashboard' "$LOCAL_K8S_DASHBOARD_PORT:$K8S_DASHBOARD_PORT" | tee -a "$REPORT") >> nohup.out 2>> nohup.err < /dev/null &
    
    DEFAULT_MK8S_TOKEN=$(microk8s kubectl -n kube-system get secret --output=jsonpath='{.data.token}' "$(microk8s kubectl -n kube-system get secret | grep 'default-token' | cut -d " " -f1)")
    echo -e "default microk8s token:\n$DEFAULT_MK8S_TOKEN" | tee -a "$REPORT"
    K8S_DASHBOARD_PORT=$(microk8s kubectl get -n 'kube-system' 'service/kubernetes-dashboard' --output=jsonpath='{.spec.ports[0].port}')
    LOCAL_K8S_DASHBOARD_PORT=3443
  
  fi
  
  curl http://localhost:12321 | tee -a "$REPORT"
  curl http://localhost:12321 | grep 'Akri'
  curl http://localhost:12321 | grep 'camera_frame_feed'
  
  echo -e " " | tee -a "$REPORT"
  echo -e "gcloud command for port-forwarding of K8s & Akri dashboards:  gcloud compute ssh $AKRI_INSTANCE --zone=$GCP_ZONE"  ' --project=$GCP_PROJECT ' "--ssh-flag='-L $LOCAL_K8S_DASHBOARD_PORT:localhost:$LOCAL_K8S_DASHBOARD_PORT -L $LOCAL_AKRI_DASHBOARD_PORT:localhost:$LOCAL_AKRI_DASHBOARD_PORT'"  | tee -a "$REPORT"
  echo -e " " | tee -a "$REPORT"
  echo -e "K8s authentication token: $(microk8s config | grep token | awk '{print $2}')" | tee -a "$REPORT"
  echo -e "K8s dashboard: https://localhost:$LOCAL_K8S_DASHBOARD_PORT" | tee -a "$REPORT"
  echo -e "Akri dashboard:  http://localhost:$LOCAL_AKRI_DASHBOARD_PORT" | tee -a "$REPORT"
  
  
  echo -e "\n### prepare execution report:"

  echo -e "### execution date: $(date --utc)" >> "$REPORT.tmp"
  echo -e " " >> "$REPORT.tmp"

  echo -e "### microk8s snap version:" >> "$REPORT.tmp"
  echo -e "$(sudo snap list | grep 'microk8s')" >> "$REPORT.tmp"
  echo -e " " >> "$REPORT.tmp"
  
  echo -e "### gstreamer version:" >> "$REPORT.tmp"
  echo -e "$(gst-launch-1.0 --version)" >> "$REPORT.tmp"
  echo -e " " >> "$REPORT.tmp"

  echo -e "### ubuntu version:" >> "$REPORT.tmp"
  echo -e "$(uname -a)" >> "$REPORT.tmp"
  echo -e "$(lsb_release -a)" >> "$REPORT.tmp"
  echo -e " " >> "$REPORT.tmp"
   
  cat $REPORT >> "$REPORT.tmp"
  rm "$REPORT"
  mv "$REPORT.tmp" $REPORT
  
  echo -e "$STEP_COMPLETED $STEP"
  echo -e "$SCRIPT_COMPLETED"
  
  exit
  
}

exec_main()
{
  STEP="$1"
  echo -e "### script step: $STEP"
  
  case $STEP in
	1)
		exec_step1 "$STEP"
		;;
	2)
		exec_step2 "$STEP"
		;;
	*)
	  echo -e "Unknown step: $STEP"
		exit 1
		;;
  esac
  
}

exec_main "$1"