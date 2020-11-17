#!/bin/bash

#source: https://cloudblogs.microsoft.com/opensource/2020/10/20/announcing-akri-open-source-project-building-connected-edge-kubernetes/
#source: https://github.com/deislabs/akri/blob/main/docs/end-to-end-demo.md
#https://medium.com/akri/say-hello-to-akri-5b183cd397a8

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

if [[ -z ${MK8S_VERSION+x} ]]                                ; then MK8S_VERSION='1.19'                        ; fi ; echo "mk8s version: $MK8S_VERSION"
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
      $GCE_INSTANCE   

}


if [[ ! "$ON_GCE" == *'Google'* ]]
then

  echo -e "\n### not on GCE\n"
  
  create_gce_instance "$AKRI_INSTANCE" "$AKRI_IMAGE_FAMILY" "$AKRI_IMAGE_PROJECT" 
      
  gcloud compute ssh $AKRI_INSTANCE --command='sudo rm -rf /var/lib/apt/lists/* && sudo apt update -y && (sudo apt upgrade -y || sudo apt upgrade -y) && sudo apt autoremove -y' --zone $GCP_ZONE --project=$GCP_PROJECT
  gcloud compute scp $0  $AKRI_INSTANCE:$(basename $0) --zone $GCP_ZONE --project=$GCP_PROJECT
  gcloud compute ssh $AKRI_INSTANCE --command="sudo chmod ugo+x ./$(basename $0)" --zone $GCP_ZONE --project=$GCP_PROJECT
  
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
  rm "$AKRI_INSTANCE-step-report-*"
  
  if [[ "$AKRI_GCE_DELETE" == 'true' ]]
  then
    echo "delete_gce_instance $AKRI_INSTANCE"
  fi
  
  exit 0
  
fi

#gcloud compute ssh microk8s-akri --zone 'us-central1-c' --project=$GCP_PROJECT

echo -e "\n### running on GCE\n"

[[ -d '.kube' ]] || mkdir '.kube'
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

  #if [[ -z $(which helm) ]]
  #then
    #echo -e "\n### installing helm: "
    #sudo snap install helm --classic
    #sudo snap list | grep 'helm'
    #helm version | grep 'v3'
  #fi
  
  if [[ "$VIDEO_INSTALL" == 'true' ]]
  then
  
    if [[ ! $(lsmod | grep 'v4l2loopback') == *'v4l2loopback'* ]]
    then 
      echo -e "\n### load kernel module v4l2loopback: "
      #v0.12.5 is imperative (gstreamer will fail if lower) - 0.12.5 starts with Ubuntu 10.10
      sudo apt update -y && sudo apt install -y dkms v4l-utils
      sudo apt install -y "linux-modules-extra-$(uname -r)"
      curl http://deb.debian.org/debian/pool/main/v/v4l2loopback/v4l2loopback-dkms_0.12.5-1_all.deb -o v4l2loopback-dkms_0.12.5-1_all.deb
      sudo dpkg -i v4l2loopback-dkms_0.12.5-1_all.deb
      #to obtain v0.12.5 (or better)
      #sudo apt install -y "linux-modules-extra-$(uname -r)"
      #sudo add-apt-repository 'deb http://us.archive.ubuntu.com/ubuntu/ groovy universe multiverse'
      #sudo add-apt-repository 'deb http://us.archive.ubuntu.com/ubuntu/ groovy-updates universe multiverse'
      #sudo apt install -y v4l2loopback-dkms v4l-utils
      #sudo apt install -y v4l2loopback-dkms
    
      sudo modprobe v4l2loopback exclusive_caps=1 devices=2 video_nr=1,2
   
      echo -e "\n### check kernel modules: "
      lsmod | grep 'videodev'
      lsmod | grep 'v4l2loopback'
      modinfo 'v4l2loopback'| grep 'vermagic'
    fi
  
    echo -e "\n### check devices: "
    ls -l /dev/video1
    ls -l /dev/video2
  
    #echo -e "\n### v4l42-ctl --all: "
    #v4l2-ctl --all -d /dev/video1
    #v4l2-ctl --all -d /dev/video2
    
    if [[ -z $(which ffmpeg) ]]
    then
      echo -e "\n### install ffmpeg: "
      sudo apt install -y ffmpeg
      echo -e "ffmpeg path: $(which ffmpeg)"
      ffmpeg -version
    fi
    
  fi
  
  if [[ -z $(which microk8s) ]]
  then
    echo -e "\n### install microk8s: "
    sudo snap install 'microk8s' --classic --channel="$MK8S_VERSION"
    sudo snap list | grep 'microk8s'
    sudo microk8s status --wait-ready --timeout 120
    echo -e "\n### authorizing user to microk8s: "
    sudo usermod -a -G 'microk8s' $USER
    sudo chown -f -R $USER ~/.kube
    echo -e "\n### groups for user: $(groups)"
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
  
  echo -e "\n### reload v4l2loopback (if needed): "
  lsmod | grep 'v4l2loopback' || sudo modprobe v4l2loopback exclusive_caps=1 devices=2 video_nr=1,2
  
  echo -e "\n### check video devices: "
  ls -l /dev/video1
  ls -l /dev/video2

  echo -e "\n### start ffmpeg streams (in background): "
  ffmpeg -filter_complex loop=loop=-1:size=700 -f lavfi -i testsrc -f v4l2 /dev/video1 > stdout-video1.log 2>&1 < /dev/null &
  ffmpeg -filter_complex loop=loop=-1:size=700 -f lavfi -i smptebars -f v4l2 /dev/video2 > stdout-video2.log 2>&1 < /dev/null &
  #while [[ ! $(ffmpeg -hide_banner -sources v4l2 | grep '/dev/video2') == *'/dev/video2'* ]]
  #do
    #echo -e "video streams not ready: sleeping 5s..."
    #sleep 5s 
  #done
  ffmpeg -hide_banner -sources v4l2 | grep 'Auto-detected'
  #ffmpeg -hide_banner -sources v4l2 | grep '/dev/video1' || true
  #ffmpeg -hide_banner -sources v4l2 | grep '/dev/video2' || true
  
  ls -l "$KUBE_CONFIG"
  microk8s config > "$KUBE_CONFIG"
  echo -e "\n### microk8s kube-config:"
  cat "$KUBE_CONFIG"
 
  #echo -e "\n### allowing privileged containers: "
  #microk8s stop
  # sudo required to update : /var/snap/microk8s/current/args/kube-apiserver
  #sudo cat /var/snap/microk8s/current/args/kube-apiserver | grep -- '--allow-privileged=true'  || sudo echo '--allow-privileged=true' >> /var/snap/microk8s/current/args/kube-apiserver
   
  #echo -e "\n### restarting microk8s: "
  #microk8s start
  #echo -e "\n### wait for cluster ready: "
  #microk8s status --wait-ready --timeout 120
  microk8s status | grep 'microk8s is running'
  
  echo -e "\n### enabling addons: "
  microk8s enable dns
  microk8s enable helm3
  microk8s enable rbac
  
  echo -e "\n### checking crictl: "
  which crictl | grep 'crictl'
  
  if [[ "$AKRI_INSTALL" == 'true' ]]
  then 
  
    echo -e "\n### install akri chart: "
    microk8s helm3 repo list | grep 'akri-helm-charts' || microk8s helm3 repo add 'akri-helm-charts' 'https://deislabs.github.io/akri/'
    echo -e "critctl path: $(which 'crictl' | grep '/usr/local/bin/crictl')"
    export AKRI_HELM_CRICTL_CONFIGURATION='--set agent.host.crictl=/usr/local/bin/crictl --set agent.host.dockerShimSock=/var/snap/microk8s/common/run/containerd.sock'
                                                            
    microk8s helm3 install 'akri' 'akri-helm-charts/akri-dev' \
        "$AKRI_HELM_CRICTL_CONFIGURATION" \
        --set useLatestContainers=true \
        --set udevVideo.enabled=true \
        --set udev.name=akri-udev-video \
        --set udevVideo.udevRules[0]='KERNEL=="video[0-9]*"' \
        --set udev.brokerPod.image.repository="ghcr.io/deislabs/akri/udev-video-broker:latest-dev"
    
    microk8s kubectl wait --for=condition=available --timeout=120s 'deployment.apps/akri-controller-deployment' -n default
    microk8s kubectl wait pod --for=condition=ready --timeout=120s --selector=akri.sh/configuration=akri-udev-video -n default

    echo -e "\n### install video streaming app: "
    microk8s kubectl apply -f "https://raw.githubusercontent.com/deislabs/akri/main/deployment/samples/akri-video-streaming-app.yaml"
    microk8s kubectl wait --for=condition=available --timeout=50s 'deployment.apps/akri-video-streaming-app' -n default
    
    NODEPORT=$(microk8s.kubectl get service/akri-video-streaming-app --output=jsonpath='{.spec.ports[?(@.name==\"http\")].nodePort}')
    echo -e "Node port: $NODEPORT"
    
  fi
  
  echo -e "$STEP_COMPLETED $STEP"
  echo -e "$SCRIPT_COMPLETED"
}

exec_main()
{
  STEP=$1
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

exec_main $1