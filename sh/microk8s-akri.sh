#!/bin/bash

set -e
trap 'catch $? $LINENO' EXIT
catch() {
  if [ "$1" != "0" ]; then
    echo "Error $1 occurred on $2"
    #delete_gce_instance $AKRI_INSTANCE
  fi
}

REPORT='report.md'

OS=$(uname -a)
echo "$OS"  | tee "$REPORT"
if [[ "$OS" == 'Linux'* ]]
then
   lsb_release -a | tee "$REPORT"
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
  STEP_REPORT="$AKRI_INSTANCE-step-report-$STEP.log" && touch "$STEP_REPORT"
  while [[ ! $(cat "$STEP_REPORT" | grep "$SCRIPT_COMPLETED") && $I -lt 2 ]]
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
          STEP_REPORT="akri-step-report-$STEP.log" && touch "$STEP_REPORT"
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
  rm -f "$AKRI_INSTANCE-step-report-*" || true
  
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
    #UPDATE: VERSION="v1.17.0" -> "v1.19.0"
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
      echo -e "\n### build kernel module v4l2loopback: "
      #v0.12.5 is imperative (gstreamer will fail if lower) - 0.12.5 starts with Ubuntu 20.10 or newer
      sudo apt update -y && sudo apt install -y dkms
      sudo apt install -y "linux-modules-extra-$(uname -r)"
      curl http://deb.debian.org/debian/pool/main/v/v4l2loopback/v4l2loopback-dkms_0.12.5-1_all.deb -o v4l2loopback-dkms_0.12.5-1_all.deb
      sudo dpkg -i v4l2loopback-dkms_0.12.5-1_all.deb
      
    fi
    
    echo -e "\n### load kernel module v4l2loopback: "
    sudo modprobe v4l2loopback exclusive_caps=1 devices=2 video_nr=1,2
   
    echo -e "\n### check required kernel modules: "
    lsmod | grep 'videodev'
    lsmod | grep 'v4l2loopback'
    modinfo 'v4l2loopback'| grep 'vermagic'
  
    echo -e "\n### check devices: "
    ls -l /dev/video1
    ls -l /dev/video2
    
    if [[ -z $(which ffmpeg) ]]
    then
      echo -e "\n### install video streamer: "
      sudo apt install -y ffmpeg
      echo -e "ffmpeg path: $(which ffmpeg)"
      ffmpeg -version
    fi
    
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
    #sudo snap install 'microk8s' --classic --channel="$MK8S_VERSION"
    sudo snap install 'microk8s' --classic --channel=latest/edge
    sudo snap list | grep 'microk8s'
    sudo microk8s status --wait-ready --timeout 120
    sudo usermod -a -G 'microk8s' "$USER"
    echo -e "groups for user: $(groups)"
  fi
  
  echo -e "$STEP_COMPLETED $STEP"
  
  if [[ -f /var/run/reboot-required ]]
  then
    echo 'WARNING: reboot required. Reboot in 2s...'
    sleep 2s
    sudo reboot
  fi

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
  	echo -e "\n### start video streams (in background): "
  	sudo gst-launch-1.0 -v videotestsrc pattern=ball ! "video/x-raw,width=640,height=480,framerate=10/1" ! avenc_mjpeg ! v4l2sink device=/dev/video1 &
    sudo gst-launch-1.0 -v videotestsrc pattern=smpte horizontal-speed=1 ! "video/x-raw,width=640,height=480,framerate=10/1" ! avenc_mjpeg ! v4l2sink device=/dev/video2 &
    sleep 15s
  fi
  
  #ffmpeg -filter_complex loop=loop=-1:size=700 -f lavfi -i testsrc -f v4l2 /dev/video1 > stdout-video1.log 2>&1 < /dev/null &
  #ffmpeg -filter_complex loop=loop=-1:size=700 -f lavfi -i smptebars -f v4l2 /dev/video2 > stdout-video2.log 2>&1 < /dev/null &
  #while [[ ! $(ffmpeg -hide_banner -sources v4l2 | grep '/dev/video2') == *'/dev/video2'* ]]
  #do
    #echo -e "video streams not ready: sleeping 5s..."
    #sleep 5s 
  #done
  #ffmpeg -hide_banner -sources v4l2 | grep 'Auto-detected'
  #ffmpeg -hide_banner -sources v4l2 | grep '/dev/video1' || true
  #ffmpeg -hide_banner -sources v4l2 | grep '/dev/video2' || true
  
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
     microk8s status --wait-ready --timeout 120
     microk8s status | grep 'microk8s is running'
  fi
  
  echo -e "\n### enabling addons: "
  microk8s enable dns
  microk8s enable helm3
  microk8s enable rbac
  microk8s enable dashboard
  #to add dashboard to kubectl cluster-info
  microk8s kubectl label service/kubernetes-dashboard kubernetes.io/cluster-service=true --namespace kube-system || true
  microk8s status --wait-ready --timeout 120
  
  DEFAULT_MK8S_TOKEN=$(microk8s kubectl -n kube-system get secret --output=jsonpath='{.data.token}' "$(microk8s kubectl -n kube-system get secret | grep 'default-token' | cut -d " " -f1)")
  echo -e "default microk8s token:\n$DEFAULT_MK8S_TOKEN"
  K8S_DASHBOARD_PORT=$(microk8s kubectl get -n 'kube-system' 'service/kubernetes-dashboard' --output=jsonpath='{.spec.ports[0].port}')
  LOCAL_K8S_DASHBOARD_PORT=3443
  echo -e "Kubernetes dashboard ports - microk8s:  $K8S_DASHBOARD_PORT - local: LOCAL_K8S_DASHBOARD_PORT "
  microk8s kubectl port-forward -n 'kube-system' 'service/kubernetes-dashboard' "$LOCAL_K8S_DASHBOARD_PORT:$K8S_DASHBOARD_PORT" &
  
  if [[ "$AKRI_INSTALL" == 'true' ]]
  then 
  
    echo -e "\n### checking crictl: "
    which crictl | grep '/usr/local/bin/crictl'
    echo -e "check microk8s containerd socket:"
    ls -l /var/snap/microk8s/common/run/containerd.sock
    ls -l /var/snap/microk8s/common/run/containerd.sock  | awk '{print $1}' | grep 'srw'
  
    echo -e "\n### install akri chart: "
    microk8s helm3 repo list | grep 'akri-helm-charts' || microk8s helm3 repo add 'akri-helm-charts' 'https://deislabs.github.io/akri/'
    
    AKRI_HELM_CRICTL_CONFIGURATION="--set agent.host.crictl=/usr/local/bin/crictl --set agent.host.dockerShimSock=/var/snap/microk8s/common/run/containerd.sock"
                                                      
    microk8s helm3 install 'akri'  \
        'akri-helm-charts/akri-dev' \
        $AKRI_HELM_CRICTL_CONFIGURATION \
        --set useLatestContainers=true \
        --set udev.enabled=true \
        --set udev.name=akri-udev-video \
        --set udev.udevRules[0]='KERNEL=="video[0-9]*"' \
        --set udev.brokerPod.image.repository='ghcr.io/deislabs/akri/udev-video-broker:latest-dev'
    
    echo -e "\n### waiting for installed chart to get ready: "
    microk8s kubectl wait --for=condition=available --timeout=120s 'deployment.apps/akri-controller-deployment' -n default || true
    
    microk8s kubectl get -o wide akric
    
    echo -e "\n### install video streaming app: "
    microk8s kubectl apply -f "https://raw.githubusercontent.com/deislabs/akri/main/deployment/samples/akri-video-streaming-app.yaml"
    microk8s kubectl wait --for=condition=available --timeout=50s 'deployment.apps/akri-video-streaming-app' -n default
    
    microk8s kubectl get -o wide pods --all-namespaces
    microk8s kubectl get -o wide daemonsets --all-namespaces
    microk8s kubectl get -o wide services --all-namespaces
   
    
    AKRI_DASHBOARD_PORT=$(microk8s kubectl get service/akri-video-streaming-app --output=jsonpath='{.spec.ports[0].port}')
    echo -e "Akri dashboard port: $AKRI_DASHBOARD_PORT"
    LOCAL_AKRI_DASHBOARD_PORT=12321
    echo -e "Kubernetes dashboard ports - microk8s:  $AKRI_DASHBOARD_PORT - local: LOCAL_AKRI_DASHBOARD_PORT "
    microk8s kubectl port-forward -n 'default' 'service/akri-video-streaming-app' "$LOCAL_AKRI_DASHBOARD_PORT:$AKRI_DASHBOARD_PORT" &
    
  fi
  
  echo -e "$STEP_COMPLETED $STEP"
  echo -e "$SCRIPT_COMPLETED"
  
  echo -e "gcloud command for access to K8s & Akri dashboards gcloud compute ssh $AKRI_INSTANCE --zone=$GCP_ZONE"  ' --project=$GCP_PROJECT ' "--ssh-flag='-L $LOCAL_K8S_DASHBOARD_PORT:localhost:$LOCAL_K8S_DASHBOARD_PORT -L $LOCAL_AKRI_DASHBOARD_PORT:localhost:$LOCAL_AKRI_DASHBOARD_PORT'"
  echo -e "use authentication token: $(microk8s config | grep token | awk '{print $2}')"
  echo -e "k8s dashboard: https://localhost:$LOCAL_K8S_DASHBOARD_PORT - akri dashboard:  https://localhost:$LOCAL_AKRI_DASHBOARD_PORT"
  echo -e "akri dashboard:  https://localhost:$LOCAL_AKRI_DASHBOARD_PORT"
  
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