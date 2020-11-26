Tests with [Akri project](https://github.com/deislabs/akri) by Microsoft: Work in Progress
## Execution Report
```
### execution date: Thu Nov 26 13:27:22 UTC 2020
 
### microk8s snap version:
microk8s          v1.19.3    1791   1.19/stable      canonical*         classic
 
### crictl version:

 
### gstreamer version:
gst-launch-1.0 version 1.16.2
GStreamer 1.16.2
https://launchpad.net/distros/ubuntu/+source/gstreamer1.0
 
### ubuntu version:
Linux microk8s-akri 5.4.0-1029-gcp #31-Ubuntu SMP Wed Oct 21 19:38:01 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
Distributor ID:	Ubuntu
Description:	Ubuntu 20.04.1 LTS
Release:	20.04
Codename:	focal
 
### execution date: Thu Nov 26 13:21:22 UTC 2020
 
### microk8s snap version:
microk8s          v1.19.3    1791   1.19/stable      canonical*         classic
 
### crictl version:

 
### gstreamer version:
gst-launch-1.0 version 1.16.2
GStreamer 1.16.2
https://launchpad.net/distros/ubuntu/+source/gstreamer1.0
 
### ubuntu version:
Linux microk8s-akri 5.4.0-1029-gcp #31-Ubuntu SMP Wed Oct 21 19:38:01 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
Distributor ID:	Ubuntu
Description:	Ubuntu 20.04.1 LTS
Release:	20.04
Codename:	focal
 
### execution date: Thu Nov 26 13:14:12 UTC 2020
 
### microk8s snap version:
microk8s          v1.19.3    1791   1.19/stable      canonical*         classic
 
### crictl version:

 
### gstreamer version:
gst-launch-1.0 version 1.16.2
GStreamer 1.16.2
https://launchpad.net/distros/ubuntu/+source/gstreamer1.0
 
### ubuntu version:
Linux microk8s-akri 5.4.0-1029-gcp #31-Ubuntu SMP Wed Oct 21 19:38:01 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
Distributor ID:	Ubuntu
Description:	Ubuntu 20.04.1 LTS
Release:	20.04
Codename:	focal
 
### execution date: Thu Nov 26 13:02:28 UTC 2020
 
### microk8s snap version:
microk8s          v1.19.3    1791   1.19/stable      canonical*         classic
 
### crictl version:

 
### gstreamer version:
gst-launch-1.0 version 1.16.2
GStreamer 1.16.2
https://launchpad.net/distros/ubuntu/+source/gstreamer1.0
 
### ubuntu version:
Linux microk8s-akri 5.4.0-1029-gcp #31-Ubuntu SMP Wed Oct 21 19:38:01 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
Distributor ID:	Ubuntu
Description:	Ubuntu 20.04.1 LTS
Release:	20.04
Codename:	focal
 
### execution date: Thu Nov 26 12:53:47 UTC 2020
 
### microk8s snap version:
microk8s          v1.19.3    1791   1.19/stable      canonical*         classic
 
### crictl version:

 
### gstreamer version:
gst-launch-1.0 version 1.16.2
GStreamer 1.16.2
https://launchpad.net/distros/ubuntu/+source/gstreamer1.0
 
### ubuntu version:
Linux microk8s-akri 5.4.0-1029-gcp #31-Ubuntu SMP Wed Oct 21 19:38:01 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
Distributor ID:	Ubuntu
Description:	Ubuntu 20.04.1 LTS
Release:	20.04
Codename:	focal
 

### build kernel module v4l2loopback: 
Selecting previously unselected package v4l2loopback-dkms.
(Reading database ... 73898 files and directories currently installed.)
Preparing to unpack v4l2loopback-dkms_0.12.5-1_all.deb ...
Unpacking v4l2loopback-dkms (0.12.5-1) ...
Setting up v4l2loopback-dkms (0.12.5-1) ...

### load kernel module v4l2loopback: 

### check required kernel modules: 
videodev              225280  1 v4l2loopback
mc                     53248  1 videodev
v4l2loopback           40960  0
videodev              225280  1 v4l2loopback
vermagic:       5.4.0-1029-gcp SMP mod_unload 

### check devices: 
crw------- 1 root root 81, 0 Nov 26 12:14 /dev/video1
crw------- 1 root root 81, 1 Nov 26 12:14 /dev/video2

### load kernel module v4l2loopback: 

### check required kernel modules: 
videodev              225280  1 v4l2loopback
mc                     53248  1 videodev
v4l2loopback           40960  0
videodev              225280  1 v4l2loopback
vermagic:       5.4.0-1029-gcp SMP mod_unload 

### check devices: 
crw-rw---- 1 root video 81, 0 Nov 26 12:40 /dev/video1
crw-rw---- 1 root video 81, 1 Nov 26 12:40 /dev/video2

### start video streams (in background): 
Setting pipeline to PAUSED ...
Pipeline is PREROLLING ...
/GstPipeline:pipeline0/GstVideoTestSrc:videotestsrc0.GstPad:src: caps = video/x-raw, format=(string)I420, width=(int)640, height=(int)480, framerate=(fraction)10/1, multiview-mode=(string)mono, colorimetry=(string)2:4:7:1, pixel-aspect-ratio=(fraction)1/1, interlace-mode=(string)progressive
/GstPipeline:pipeline0/GstCapsFilter:capsfilter0.GstPad:src: caps = video/x-raw, format=(string)I420, width=(int)640, height=(int)480, framerate=(fraction)10/1, multiview-mode=(string)mono, colorimetry=(string)2:4:7:1, pixel-aspect-ratio=(fraction)1/1, interlace-mode=(string)progressive
Setting pipeline to PAUSED ...
Pipeline is PREROLLING ...
/GstPipeline:pipeline0/GstVideoTestSrc:videotestsrc0.GstPad:src: caps = video/x-raw, format=(string)I420, width=(int)640, height=(int)480, framerate=(fraction)10/1, multiview-mode=(string)mono, colorimetry=(string)2:4:7:1, pixel-aspect-ratio=(fraction)1/1, interlace-mode=(string)progressive
/GstPipeline:pipeline0/GstCapsFilter:capsfilter0.GstPad:src: caps = video/x-raw, format=(string)I420, width=(int)640, height=(int)480, framerate=(fraction)10/1, multiview-mode=(string)mono, colorimetry=(string)2:4:7:1, pixel-aspect-ratio=(fraction)1/1, interlace-mode=(string)progressive
/GstPipeline:pipeline0/avenc_mjpeg:avenc_mjpeg0.GstPad:sink: caps = video/x-raw, format=(string)I420, width=(int)640, height=(int)480, framerate=(fraction)10/1, multiview-mode=(string)mono, colorimetry=(string)2:4:7:1, pixel-aspect-ratio=(fraction)1/1, interlace-mode=(string)progressive
/GstPipeline:pipeline0/avenc_mjpeg:avenc_mjpeg0.GstPad:sink: caps = video/x-raw, format=(string)I420, width=(int)640, height=(int)480, framerate=(fraction)10/1, multiview-mode=(string)mono, colorimetry=(string)2:4:7:1, pixel-aspect-ratio=(fraction)1/1, interlace-mode=(string)progressive
/GstPipeline:pipeline0/GstCapsFilter:capsfilter0.GstPad:sink: caps = video/x-raw, format=(string)I420, width=(int)640, height=(int)480, framerate=(fraction)10/1, multiview-mode=(string)mono, colorimetry=(string)2:4:7:1, pixel-aspect-ratio=(fraction)1/1, interlace-mode=(string)progressive
/GstPipeline:pipeline0/GstCapsFilter:capsfilter0.GstPad:sink: caps = video/x-raw, format=(string)I420, width=(int)640, height=(int)480, framerate=(fraction)10/1, multiview-mode=(string)mono, colorimetry=(string)2:4:7:1, pixel-aspect-ratio=(fraction)1/1, interlace-mode=(string)progressive
/GstPipeline:pipeline0/avenc_mjpeg:avenc_mjpeg0.GstPad:src: caps = image/jpeg, parsed=(boolean)true, width=(int)640, height=(int)480, colorimetry=(string)2:4:7:1, framerate=(fraction)10/1, pixel-aspect-ratio=(fraction)1/1, interlace-mode=(string)progressive, multiview-mode=(string)mono, multiview-flags=(GstVideoMultiviewFlagsSet)0:ffffffff:/right-view-first/left-flipped/left-flopped/right-flipped/right-flopped/half-aspect/mixed-mono
/GstPipeline:pipeline0/GstV4l2Sink:v4l2sink0.GstPad:sink: caps = image/jpeg, parsed=(boolean)true, width=(int)640, height=(int)480, colorimetry=(string)2:4:7:1, framerate=(fraction)10/1, pixel-aspect-ratio=(fraction)1/1, interlace-mode=(string)progressive, multiview-mode=(string)mono, multiview-flags=(GstVideoMultiviewFlagsSet)0:ffffffff:/right-view-first/left-flipped/left-flopped/right-flipped/right-flopped/half-aspect/mixed-mono
Pipeline is PREROLLED ...
Setting pipeline to PLAYING ...
New clock: GstSystemClock
/GstPipeline:pipeline0/avenc_mjpeg:avenc_mjpeg0.GstPad:src: caps = image/jpeg, parsed=(boolean)true, width=(int)640, height=(int)480, colorimetry=(string)2:4:7:1, framerate=(fraction)10/1, pixel-aspect-ratio=(fraction)1/1, interlace-mode=(string)progressive, multiview-mode=(string)mono, multiview-flags=(GstVideoMultiviewFlagsSet)0:ffffffff:/right-view-first/left-flipped/left-flopped/right-flipped/right-flopped/half-aspect/mixed-mono
/GstPipeline:pipeline0/GstV4l2Sink:v4l2sink0.GstPad:sink: caps = image/jpeg, parsed=(boolean)true, width=(int)640, height=(int)480, colorimetry=(string)2:4:7:1, framerate=(fraction)10/1, pixel-aspect-ratio=(fraction)1/1, interlace-mode=(string)progressive, multiview-mode=(string)mono, multiview-flags=(GstVideoMultiviewFlagsSet)0:ffffffff:/right-view-first/left-flipped/left-flopped/right-flipped/right-flopped/half-aspect/mixed-mono
Pipeline is PREROLLED ...
Setting pipeline to PLAYING ...
New clock: GstSystemClock

### enabling microk8s addons: 
Enabling DNS
Applying manifest
serviceaccount/coredns created
configmap/coredns created
deployment.apps/coredns created
service/kube-dns created
clusterrole.rbac.authorization.k8s.io/coredns created
clusterrolebinding.rbac.authorization.k8s.io/coredns created
Restarting kubelet
DNS is enabled
Enabling Helm 3
Fetching helm version v3.0.2.
Helm 3 is enabled
Enabling RBAC
Reconfiguring apiserver
RBAC is enabled
Enabling Kubernetes Dashboard
Enabling Metrics-Server
clusterrole.rbac.authorization.k8s.io/system:aggregated-metrics-reader created
clusterrolebinding.rbac.authorization.k8s.io/metrics-server:system:auth-delegator created
rolebinding.rbac.authorization.k8s.io/metrics-server-auth-reader created
apiservice.apiregistration.k8s.io/v1beta1.metrics.k8s.io created
serviceaccount/metrics-server created
deployment.apps/metrics-server created
service/metrics-server created
clusterrole.rbac.authorization.k8s.io/system:metrics-server created
clusterrolebinding.rbac.authorization.k8s.io/system:metrics-server created
clusterrolebinding.rbac.authorization.k8s.io/microk8s-admin created
Metrics-Server is enabled
Applying manifest
serviceaccount/kubernetes-dashboard created
service/kubernetes-dashboard created
secret/kubernetes-dashboard-certs created
secret/kubernetes-dashboard-csrf created
secret/kubernetes-dashboard-key-holder created
configmap/kubernetes-dashboard-settings created
role.rbac.authorization.k8s.io/kubernetes-dashboard created
clusterrole.rbac.authorization.k8s.io/kubernetes-dashboard created
rolebinding.rbac.authorization.k8s.io/kubernetes-dashboard created
clusterrolebinding.rbac.authorization.k8s.io/kubernetes-dashboard created
deployment.apps/kubernetes-dashboard created
service/dashboard-metrics-scraper created
deployment.apps/dashboard-metrics-scraper created

If RBAC is not enabled access the dashboard using the default token retrieved with:

token=$(microk8s kubectl -n kube-system get secret | grep default-token | cut -d " " -f1)
microk8s kubectl -n kube-system describe secret $token

In an RBAC enabled setup (microk8s enable RBAC) you need to create a user with restricted
permissions as shown in:
https://github.com/kubernetes/dashboard/blob/master/docs/user/access-control/creating-sample-user.md


### install akri chart: 
"akri-helm-charts" has been added to your repositories
NAME: akri
LAST DEPLOYED: Thu Nov 26 12:42:56 2020
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
1. Get the Akri Controller:
  kubectl get -o wide pods | grep controller
2. Get the Akri Agent(s):
  kubectl get -o wide pods | grep agent
3. Get the Akri Configuration(s):
  kubectl get -o wide akric

### waiting for installed chart to get ready: 
deployment.apps/akri-controller-deployment condition met

### get akri configuration: 
NAME              CAPACITY   AGE
akri-udev-video   1          60s

### install video streaming app: 
deployment.apps/akri-video-streaming-app created
service/akri-video-streaming-app created
deployment.apps/akri-video-streaming-app condition met

### get pods --all-namespaces: 
NAMESPACE     NAME                                          READY   STATUS    RESTARTS   AGE     IP            NODE            NOMINATED NODE   READINESS GATES
kube-system   calico-node-hbzcs                             1/1     Running   2          23m     10.128.0.44   microk8s-akri   <none>           <none>
kube-system   metrics-server-8bbfb4bdb-vm9zn                1/1     Running   0          2m26s   10.1.54.68    microk8s-akri   <none>           <none>
kube-system   coredns-86f78bb79c-dhwvp                      1/1     Running   0          2m56s   10.1.54.67    microk8s-akri   <none>           <none>
kube-system   calico-kube-controllers-847c8c99d-9dn98       1/1     Running   1          23m     10.1.54.66    microk8s-akri   <none>           <none>
kube-system   kubernetes-dashboard-7ffd448895-9jh65         1/1     Running   0          2m24s   10.1.54.69    microk8s-akri   <none>           <none>
kube-system   dashboard-metrics-scraper-6c4568dc68-ch6vk    1/1     Running   0          2m24s   10.1.54.70    microk8s-akri   <none>           <none>
default       akri-agent-daemonset-qq2h5                    1/1     Running   0          80s     10.128.0.44   microk8s-akri   <none>           <none>
default       akri-controller-deployment-5b4bb5cbb5-xt2sw   1/1     Running   0          80s     10.1.54.71    microk8s-akri   <none>           <none>
default       akri-udev-video-018417-pod                    1/1     Running   0          70s     10.1.54.72    microk8s-akri   <none>           <none>
default       akri-udev-video-aa247f-pod                    1/1     Running   0          70s     10.1.54.73    microk8s-akri   <none>           <none>
default       akri-video-streaming-app-fd5f4cb7d-2r9lb      1/1     Running   0          19s     10.1.54.74    microk8s-akri   <none>           <none>

### get daemonsets --all-namespaces: 
NAMESPACE     NAME                   DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE   CONTAINERS    IMAGES                                   SELECTOR
kube-system   calico-node            1         1         1       1            1           kubernetes.io/os=linux   23m   calico-node   calico/node:v3.13.2                      k8s-app=calico-node
default       akri-agent-daemonset   1         1         1       1            1           kubernetes.io/os=linux   81s   akri-agent    ghcr.io/deislabs/akri/agent:latest-dev   name=akri-agent

### get services --all-namespaces: 
NAMESPACE     NAME                         TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                  AGE     SELECTOR
default       kubernetes                   ClusterIP   10.152.183.1     <none>        443/TCP                  23m     <none>
kube-system   kube-dns                     ClusterIP   10.152.183.10    <none>        53/UDP,53/TCP,9153/TCP   2m57s   k8s-app=kube-dns
kube-system   metrics-server               ClusterIP   10.152.183.89    <none>        443/TCP                  2m27s   k8s-app=metrics-server
kube-system   kubernetes-dashboard         ClusterIP   10.152.183.42    <none>        443/TCP                  2m25s   k8s-app=kubernetes-dashboard
kube-system   dashboard-metrics-scraper    ClusterIP   10.152.183.248   <none>        8000/TCP                 2m25s   k8s-app=dashboard-metrics-scraper
default       akri-udev-video-018417-svc   ClusterIP   10.152.183.226   <none>        80/TCP                   64s     akri.sh/instance=akri-udev-video-018417,controller=akri.sh
default       akri-udev-video-svc          ClusterIP   10.152.183.227   <none>        80/TCP                   64s     akri.sh/configuration=akri-udev-video,controller=akri.sh
default       akri-udev-video-aa247f-svc   ClusterIP   10.152.183.133   <none>        80/TCP                   64s     akri.sh/instance=akri-udev-video-aa247f,controller=akri.sh
default       akri-video-streaming-app     NodePort    10.152.183.54    <none>        80:30813/TCP             20s     app=akri-video-streaming-app
Akri dashboard ports - gce:  80 - local: 12321 
K8s dashboard ports - gce:  443 - local: 3443 
Forwarding from 127.0.0.1:12321 -> 5000
Forwarding from [::1]:12321 -> 5000
Forwarding from 127.0.0.1:3443 -> 8443
Forwarding from [::1]:3443 -> 8443
Handling connection for 12321
<html>
  <head>
    <title>Akri Demo</title>
  </head>
  <body>
    <div style="max-width: 800px;  margin: auto;text-align:center">
      <h1>Akri Demo</h1>
      <div style="display: inline-block;clear:both;margin-bottom:30px">
        <img src="/camera_frame_feed/0" style="width:480px">
      </div>
      <ul style="display: block;list-style-type: none;padding:0;">
        
        <li style="display: inline-block; padding: 0 25">
          <img src="/camera_frame_feed/1" style="width:200px">
        </li>
        
        <li style="display: inline-block; padding: 0 25">
          <img src="/camera_frame_feed/2" style="width:200px">
        </li>
        
      </ul>
    </div>
  </body>
</html>Handling connection for 12321

### enabling microk8s addons: 
Addon dns is already enabled.
Addon helm3 is already enabled.
Addon rbac is already enabled.
Addon dashboard is already enabled.

### install akri chart: 
akri-helm-charts	https://deislabs.github.io/akri/

### waiting for installed chart to get ready: 
deployment.apps/akri-controller-deployment condition met

### get akri configuration: 
NAME              CAPACITY   AGE
akri-udev-video   1          3m31s

### install video streaming app: 
deployment.apps/akri-video-streaming-app unchanged
service/akri-video-streaming-app unchanged
deployment.apps/akri-video-streaming-app condition met

### get pods --all-namespaces: 
NAMESPACE     NAME                                          READY   STATUS    RESTARTS   AGE     IP            NODE            NOMINATED NODE   READINESS GATES
kube-system   calico-node-hbzcs                             1/1     Running   2          25m     10.128.0.44   microk8s-akri   <none>           <none>
kube-system   metrics-server-8bbfb4bdb-vm9zn                1/1     Running   0          4m38s   10.1.54.68    microk8s-akri   <none>           <none>
kube-system   coredns-86f78bb79c-dhwvp                      1/1     Running   0          5m8s    10.1.54.67    microk8s-akri   <none>           <none>
kube-system   calico-kube-controllers-847c8c99d-9dn98       1/1     Running   1          25m     10.1.54.66    microk8s-akri   <none>           <none>
kube-system   kubernetes-dashboard-7ffd448895-9jh65         1/1     Running   0          4m36s   10.1.54.69    microk8s-akri   <none>           <none>
kube-system   dashboard-metrics-scraper-6c4568dc68-ch6vk    1/1     Running   0          4m36s   10.1.54.70    microk8s-akri   <none>           <none>
default       akri-agent-daemonset-qq2h5                    1/1     Running   0          3m32s   10.128.0.44   microk8s-akri   <none>           <none>
default       akri-controller-deployment-5b4bb5cbb5-xt2sw   1/1     Running   0          3m32s   10.1.54.71    microk8s-akri   <none>           <none>
default       akri-udev-video-018417-pod                    1/1     Running   0          3m22s   10.1.54.72    microk8s-akri   <none>           <none>
default       akri-udev-video-aa247f-pod                    1/1     Running   0          3m22s   10.1.54.73    microk8s-akri   <none>           <none>
default       akri-video-streaming-app-fd5f4cb7d-2r9lb      1/1     Running   0          2m31s   10.1.54.74    microk8s-akri   <none>           <none>

### get daemonsets --all-namespaces: 
NAMESPACE     NAME                   DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE     CONTAINERS    IMAGES                                   SELECTOR
kube-system   calico-node            1         1         1       1            1           kubernetes.io/os=linux   25m     calico-node   calico/node:v3.13.2                      k8s-app=calico-node
default       akri-agent-daemonset   1         1         1       1            1           kubernetes.io/os=linux   3m32s   akri-agent    ghcr.io/deislabs/akri/agent:latest-dev   name=akri-agent

### get services --all-namespaces: 
NAMESPACE     NAME                         TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                  AGE     SELECTOR
default       kubernetes                   ClusterIP   10.152.183.1     <none>        443/TCP                  25m     <none>
kube-system   kube-dns                     ClusterIP   10.152.183.10    <none>        53/UDP,53/TCP,9153/TCP   5m8s    k8s-app=kube-dns
kube-system   metrics-server               ClusterIP   10.152.183.89    <none>        443/TCP                  4m38s   k8s-app=metrics-server
kube-system   kubernetes-dashboard         ClusterIP   10.152.183.42    <none>        443/TCP                  4m36s   k8s-app=kubernetes-dashboard
kube-system   dashboard-metrics-scraper    ClusterIP   10.152.183.248   <none>        8000/TCP                 4m36s   k8s-app=dashboard-metrics-scraper
default       akri-udev-video-018417-svc   ClusterIP   10.152.183.226   <none>        80/TCP                   3m15s   akri.sh/instance=akri-udev-video-018417,controller=akri.sh
default       akri-udev-video-svc          ClusterIP   10.152.183.227   <none>        80/TCP                   3m15s   akri.sh/configuration=akri-udev-video,controller=akri.sh
default       akri-udev-video-aa247f-svc   ClusterIP   10.152.183.133   <none>        80/TCP                   3m15s   akri.sh/instance=akri-udev-video-aa247f,controller=akri.sh
default       akri-video-streaming-app     NodePort    10.152.183.54    <none>        80:30813/TCP             2m31s   app=akri-video-streaming-app
Akri dashboard ports - gce:  80 - local: 12321 
K8s dashboard ports - gce:  443 - local: 3443 
Handling connection for 12321
<html>
  <head>
    <title>Akri Demo</title>
  </head>
  <body>
    <div style="max-width: 800px;  margin: auto;text-align:center">
      <h1>Akri Demo</h1>
      <div style="display: inline-block;clear:both;margin-bottom:30px">
        <img src="/camera_frame_feed/0" style="width:480px">
      </div>
      <ul style="display: block;list-style-type: none;padding:0;">
        
        <li style="display: inline-block; padding: 0 25">
          <img src="/camera_frame_feed/1" style="width:200px">
        </li>
        
        <li style="display: inline-block; padding: 0 25">
          <img src="/camera_frame_feed/2" style="width:200px">
        </li>
        
      </ul>
    </div>
  </body>
</html>Handling connection for 12321

### enabling microk8s addons: 
Addon dns is already enabled.
Addon helm3 is already enabled.
Addon rbac is already enabled.
Addon dashboard is already enabled.

### install akri chart: 
akri-helm-charts	https://deislabs.github.io/akri/

### waiting for installed chart to get ready: 
deployment.apps/akri-controller-deployment condition met

### get akri configuration: 
NAME              CAPACITY   AGE
akri-udev-video   1          5m43s

### install video streaming app: 
deployment.apps/akri-video-streaming-app unchanged
service/akri-video-streaming-app unchanged
deployment.apps/akri-video-streaming-app condition met

### get pods --all-namespaces: 
NAMESPACE     NAME                                          READY   STATUS    RESTARTS   AGE     IP            NODE            NOMINATED NODE   READINESS GATES
kube-system   calico-node-hbzcs                             1/1     Running   2          27m     10.128.0.44   microk8s-akri   <none>           <none>
kube-system   metrics-server-8bbfb4bdb-vm9zn                1/1     Running   0          6m50s   10.1.54.68    microk8s-akri   <none>           <none>
kube-system   coredns-86f78bb79c-dhwvp                      1/1     Running   0          7m20s   10.1.54.67    microk8s-akri   <none>           <none>
kube-system   calico-kube-controllers-847c8c99d-9dn98       1/1     Running   1          27m     10.1.54.66    microk8s-akri   <none>           <none>
kube-system   kubernetes-dashboard-7ffd448895-9jh65         1/1     Running   0          6m48s   10.1.54.69    microk8s-akri   <none>           <none>
kube-system   dashboard-metrics-scraper-6c4568dc68-ch6vk    1/1     Running   0          6m48s   10.1.54.70    microk8s-akri   <none>           <none>
default       akri-agent-daemonset-qq2h5                    1/1     Running   0          5m44s   10.128.0.44   microk8s-akri   <none>           <none>
default       akri-controller-deployment-5b4bb5cbb5-xt2sw   1/1     Running   0          5m44s   10.1.54.71    microk8s-akri   <none>           <none>
default       akri-udev-video-018417-pod                    1/1     Running   0          5m34s   10.1.54.72    microk8s-akri   <none>           <none>
default       akri-udev-video-aa247f-pod                    1/1     Running   0          5m34s   10.1.54.73    microk8s-akri   <none>           <none>
default       akri-video-streaming-app-fd5f4cb7d-2r9lb      1/1     Running   0          4m43s   10.1.54.74    microk8s-akri   <none>           <none>

### get daemonsets --all-namespaces: 
NAMESPACE     NAME                   DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE     CONTAINERS    IMAGES                                   SELECTOR
kube-system   calico-node            1         1         1       1            1           kubernetes.io/os=linux   27m     calico-node   calico/node:v3.13.2                      k8s-app=calico-node
default       akri-agent-daemonset   1         1         1       1            1           kubernetes.io/os=linux   5m44s   akri-agent    ghcr.io/deislabs/akri/agent:latest-dev   name=akri-agent

### get services --all-namespaces: 
NAMESPACE     NAME                         TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                  AGE     SELECTOR
default       kubernetes                   ClusterIP   10.152.183.1     <none>        443/TCP                  27m     <none>
kube-system   kube-dns                     ClusterIP   10.152.183.10    <none>        53/UDP,53/TCP,9153/TCP   7m20s   k8s-app=kube-dns
kube-system   metrics-server               ClusterIP   10.152.183.89    <none>        443/TCP                  6m50s   k8s-app=metrics-server
kube-system   kubernetes-dashboard         ClusterIP   10.152.183.42    <none>        443/TCP                  6m48s   k8s-app=kubernetes-dashboard
kube-system   dashboard-metrics-scraper    ClusterIP   10.152.183.248   <none>        8000/TCP                 6m48s   k8s-app=dashboard-metrics-scraper
default       akri-udev-video-018417-svc   ClusterIP   10.152.183.226   <none>        80/TCP                   5m27s   akri.sh/instance=akri-udev-video-018417,controller=akri.sh
default       akri-udev-video-svc          ClusterIP   10.152.183.227   <none>        80/TCP                   5m27s   akri.sh/configuration=akri-udev-video,controller=akri.sh
default       akri-udev-video-aa247f-svc   ClusterIP   10.152.183.133   <none>        80/TCP                   5m27s   akri.sh/instance=akri-udev-video-aa247f,controller=akri.sh
default       akri-video-streaming-app     NodePort    10.152.183.54    <none>        80:30813/TCP             4m43s   app=akri-video-streaming-app
Akri dashboard ports - gce:  80 - local: 12321 
K8s dashboard ports - gce:  443 - local: 3443 
Handling connection for 12321
<html>
  <head>
    <title>Akri Demo</title>
  </head>
  <body>
    <div style="max-width: 800px;  margin: auto;text-align:center">
      <h1>Akri Demo</h1>
      <div style="display: inline-block;clear:both;margin-bottom:30px">
        <img src="/camera_frame_feed/0" style="width:480px">
      </div>
      <ul style="display: block;list-style-type: none;padding:0;">
        
        <li style="display: inline-block; padding: 0 25">
          <img src="/camera_frame_feed/1" style="width:200px">
        </li>
        
        <li style="display: inline-block; padding: 0 25">
          <img src="/camera_frame_feed/2" style="width:200px">
        </li>
        
      </ul>
    </div>
  </body>
</html>Handling connection for 12321

### enabling microk8s addons: 
Addon dns is already enabled.
Addon helm3 is already enabled.
Addon rbac is already enabled.
Addon dashboard is already enabled.

### load kernel module v4l2loopback: 

### check required kernel modules: 
videodev              225280  5 v4l2loopback
mc                     53248  1 videodev
v4l2loopback           40960  4
videodev              225280  5 v4l2loopback
vermagic:       5.4.0-1029-gcp SMP mod_unload 

### check devices: 
crw-rw---- 1 root video 81, 0 Nov 26 12:40 /dev/video1
crw-rw---- 1 root video 81, 1 Nov 26 12:40 /dev/video2

### enabling microk8s addons: 
Addon dns is already enabled.
Addon helm3 is already enabled.
Addon rbac is already enabled.
Addon dashboard is already enabled.

### install akri chart: 
akri-helm-charts	https://deislabs.github.io/akri/

### waiting for installed chart to get ready: 
deployment.apps/akri-controller-deployment condition met

### get akri configuration: 
NAME              CAPACITY   AGE
akri-udev-video   1          10m

### install video streaming app: 
deployment.apps/akri-video-streaming-app unchanged
service/akri-video-streaming-app unchanged
deployment.apps/akri-video-streaming-app condition met

### get pods --all-namespaces: 
NAMESPACE     NAME                                          READY   STATUS    RESTARTS   AGE     IP            NODE            NOMINATED NODE   READINESS GATES
kube-system   calico-node-hbzcs                             1/1     Running   2          32m     10.128.0.44   microk8s-akri   <none>           <none>
kube-system   metrics-server-8bbfb4bdb-vm9zn                1/1     Running   0          11m     10.1.54.68    microk8s-akri   <none>           <none>
kube-system   coredns-86f78bb79c-dhwvp                      1/1     Running   0          12m     10.1.54.67    microk8s-akri   <none>           <none>
kube-system   calico-kube-controllers-847c8c99d-9dn98       1/1     Running   1          32m     10.1.54.66    microk8s-akri   <none>           <none>
kube-system   kubernetes-dashboard-7ffd448895-9jh65         1/1     Running   0          11m     10.1.54.69    microk8s-akri   <none>           <none>
kube-system   dashboard-metrics-scraper-6c4568dc68-ch6vk    1/1     Running   0          11m     10.1.54.70    microk8s-akri   <none>           <none>
default       akri-agent-daemonset-qq2h5                    1/1     Running   0          10m     10.128.0.44   microk8s-akri   <none>           <none>
default       akri-controller-deployment-5b4bb5cbb5-xt2sw   1/1     Running   0          10m     10.1.54.71    microk8s-akri   <none>           <none>
default       akri-udev-video-018417-pod                    1/1     Running   0          10m     10.1.54.72    microk8s-akri   <none>           <none>
default       akri-udev-video-aa247f-pod                    1/1     Running   0          10m     10.1.54.73    microk8s-akri   <none>           <none>
default       akri-video-streaming-app-fd5f4cb7d-2r9lb      1/1     Running   0          9m48s   10.1.54.74    microk8s-akri   <none>           <none>

### get daemonsets --all-namespaces: 
NAMESPACE     NAME                   DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE   CONTAINERS    IMAGES                                   SELECTOR
kube-system   calico-node            1         1         1       1            1           kubernetes.io/os=linux   32m   calico-node   calico/node:v3.13.2                      k8s-app=calico-node
default       akri-agent-daemonset   1         1         1       1            1           kubernetes.io/os=linux   10m   akri-agent    ghcr.io/deislabs/akri/agent:latest-dev   name=akri-agent

### get services --all-namespaces: 
NAMESPACE     NAME                         TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                  AGE     SELECTOR
default       kubernetes                   ClusterIP   10.152.183.1     <none>        443/TCP                  32m     <none>
kube-system   kube-dns                     ClusterIP   10.152.183.10    <none>        53/UDP,53/TCP,9153/TCP   12m     k8s-app=kube-dns
kube-system   metrics-server               ClusterIP   10.152.183.89    <none>        443/TCP                  11m     k8s-app=metrics-server
kube-system   kubernetes-dashboard         ClusterIP   10.152.183.42    <none>        443/TCP                  11m     k8s-app=kubernetes-dashboard
kube-system   dashboard-metrics-scraper    ClusterIP   10.152.183.248   <none>        8000/TCP                 11m     k8s-app=dashboard-metrics-scraper
default       akri-udev-video-018417-svc   ClusterIP   10.152.183.226   <none>        80/TCP                   10m     akri.sh/instance=akri-udev-video-018417,controller=akri.sh
default       akri-udev-video-svc          ClusterIP   10.152.183.227   <none>        80/TCP                   10m     akri.sh/configuration=akri-udev-video,controller=akri.sh
default       akri-udev-video-aa247f-svc   ClusterIP   10.152.183.133   <none>        80/TCP                   10m     akri.sh/instance=akri-udev-video-aa247f,controller=akri.sh
default       akri-video-streaming-app     NodePort    10.152.183.54    <none>        80:30813/TCP             9m49s   app=akri-video-streaming-app
Akri dashboard ports - gce:  80 - local: 12321 
K8s dashboard ports - gce:  443 - local: 3443 
Handling connection for 12321
<html>
  <head>
    <title>Akri Demo</title>
  </head>
  <body>
    <div style="max-width: 800px;  margin: auto;text-align:center">
      <h1>Akri Demo</h1>
      <div style="display: inline-block;clear:both;margin-bottom:30px">
        <img src="/camera_frame_feed/0" style="width:480px">
      </div>
      <ul style="display: block;list-style-type: none;padding:0;">
        
        <li style="display: inline-block; padding: 0 25">
          <img src="/camera_frame_feed/1" style="width:200px">
        </li>
        
        <li style="display: inline-block; padding: 0 25">
          <img src="/camera_frame_feed/2" style="width:200px">
        </li>
        
      </ul>
    </div>
  </body>
</html>Handling connection for 12321
Handling connection for 12321
gcloud command for access to K8s & Akri dashboards gcloud compute ssh microk8s-akri --zone=us-central1-c  --project=$GCP_PROJECT  --ssh-flag='-L 3443:localhost:3443 -L 12321:localhost:12321'
use authentication token: Mk9XemZ6bTRqdi9iSjRPV2ZBSTFqaFNZNU1tSnFHNVh2UmdUMEhpcEh0az0K
k8s dashboard: https://localhost:3443 - akri dashboard:  https://localhost:12321
akri dashboard:  http://localhost:12321

### load kernel module v4l2loopback: 

### check required kernel modules: 
videodev              225280  5 v4l2loopback
mc                     53248  1 videodev
v4l2loopback           40960  4
videodev              225280  5 v4l2loopback
vermagic:       5.4.0-1029-gcp SMP mod_unload 

### check devices: 
crw-rw---- 1 root video 81, 0 Nov 26 12:40 /dev/video1
crw-rw---- 1 root video 81, 1 Nov 26 12:40 /dev/video2

### enabling microk8s addons: 
Addon dns is already enabled.
Addon helm3 is already enabled.
Addon rbac is already enabled.
Addon dashboard is already enabled.

### install akri chart: 
akri-helm-charts	https://deislabs.github.io/akri/

### waiting for installed chart to get ready: 
deployment.apps/akri-controller-deployment condition met

### get akri configuration: 
NAME              CAPACITY   AGE
akri-udev-video   1          19m

### install video streaming app: 
deployment.apps/akri-video-streaming-app unchanged
service/akri-video-streaming-app unchanged
deployment.apps/akri-video-streaming-app condition met

### get pods --all-namespaces: 
NAMESPACE     NAME                                          READY   STATUS    RESTARTS   AGE   IP            NODE            NOMINATED NODE   READINESS GATES
kube-system   calico-node-hbzcs                             1/1     Running   2          41m   10.128.0.44   microk8s-akri   <none>           <none>
kube-system   metrics-server-8bbfb4bdb-vm9zn                1/1     Running   0          20m   10.1.54.68    microk8s-akri   <none>           <none>
kube-system   coredns-86f78bb79c-dhwvp                      1/1     Running   0          21m   10.1.54.67    microk8s-akri   <none>           <none>
kube-system   calico-kube-controllers-847c8c99d-9dn98       1/1     Running   1          41m   10.1.54.66    microk8s-akri   <none>           <none>
kube-system   kubernetes-dashboard-7ffd448895-9jh65         1/1     Running   0          20m   10.1.54.69    microk8s-akri   <none>           <none>
kube-system   dashboard-metrics-scraper-6c4568dc68-ch6vk    1/1     Running   0          20m   10.1.54.70    microk8s-akri   <none>           <none>
default       akri-agent-daemonset-qq2h5                    1/1     Running   0          19m   10.128.0.44   microk8s-akri   <none>           <none>
default       akri-controller-deployment-5b4bb5cbb5-xt2sw   1/1     Running   0          19m   10.1.54.71    microk8s-akri   <none>           <none>
default       akri-udev-video-018417-pod                    1/1     Running   0          19m   10.1.54.72    microk8s-akri   <none>           <none>
default       akri-udev-video-aa247f-pod                    1/1     Running   0          19m   10.1.54.73    microk8s-akri   <none>           <none>
default       akri-video-streaming-app-fd5f4cb7d-2r9lb      1/1     Running   0          18m   10.1.54.74    microk8s-akri   <none>           <none>

### get daemonsets --all-namespaces: 
NAMESPACE     NAME                   DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE   CONTAINERS    IMAGES                                   SELECTOR
kube-system   calico-node            1         1         1       1            1           kubernetes.io/os=linux   41m   calico-node   calico/node:v3.13.2                      k8s-app=calico-node
default       akri-agent-daemonset   1         1         1       1            1           kubernetes.io/os=linux   19m   akri-agent    ghcr.io/deislabs/akri/agent:latest-dev   name=akri-agent

### get services --all-namespaces: 
NAMESPACE     NAME                         TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                  AGE   SELECTOR
default       kubernetes                   ClusterIP   10.152.183.1     <none>        443/TCP                  41m   <none>
kube-system   kube-dns                     ClusterIP   10.152.183.10    <none>        53/UDP,53/TCP,9153/TCP   21m   k8s-app=kube-dns
kube-system   metrics-server               ClusterIP   10.152.183.89    <none>        443/TCP                  20m   k8s-app=metrics-server
kube-system   kubernetes-dashboard         ClusterIP   10.152.183.42    <none>        443/TCP                  20m   k8s-app=kubernetes-dashboard
kube-system   dashboard-metrics-scraper    ClusterIP   10.152.183.248   <none>        8000/TCP                 20m   k8s-app=dashboard-metrics-scraper
default       akri-udev-video-018417-svc   ClusterIP   10.152.183.226   <none>        80/TCP                   19m   akri.sh/instance=akri-udev-video-018417,controller=akri.sh
default       akri-udev-video-svc          ClusterIP   10.152.183.227   <none>        80/TCP                   19m   akri.sh/configuration=akri-udev-video,controller=akri.sh
default       akri-udev-video-aa247f-svc   ClusterIP   10.152.183.133   <none>        80/TCP                   19m   akri.sh/instance=akri-udev-video-aa247f,controller=akri.sh
default       akri-video-streaming-app     NodePort    10.152.183.54    <none>        80:30813/TCP             18m   app=akri-video-streaming-app
Akri dashboard ports - gce:  80 - local: 12321 
K8s dashboard ports - gce:  443 - local: 3443 
<html>
  <head>
    <title>Akri Demo</title>
  </head>
  <body>
    <div style="max-width: 800px;  margin: auto;text-align:center">
      <h1>Akri Demo</h1>
      <div style="display: inline-block;clear:both;margin-bottom:30px">
        <img src="/camera_frame_feed/0" style="width:480px">
      </div>
      <ul style="display: block;list-style-type: none;padding:0;">
        
        <li style="display: inline-block; padding: 0 25">
          <img src="/camera_frame_feed/1" style="width:200px">
        </li>
        
        <li style="display: inline-block; padding: 0 25">
          <img src="/camera_frame_feed/2" style="width:200px">
        </li>
        
      </ul>
    </div>
  </body>
</html>gcloud command for access to K8s & Akri dashboards gcloud compute ssh microk8s-akri --zone=us-central1-c  --project=$GCP_PROJECT  --ssh-flag='-L 3443:localhost:3443 -L 12321:localhost:12321'
use authentication token: Mk9XemZ6bTRqdi9iSjRPV2ZBSTFqaFNZNU1tSnFHNVh2UmdUMEhpcEh0az0K
k8s dashboard: https://localhost:3443 - akri dashboard:  https://localhost:12321
akri dashboard:  http://localhost:12321

### load kernel module v4l2loopback: 

### check required kernel modules: 
videodev              225280  5 v4l2loopback
mc                     53248  1 videodev
v4l2loopback           40960  4
videodev              225280  5 v4l2loopback
vermagic:       5.4.0-1029-gcp SMP mod_unload 

### check devices: 
crw-rw---- 1 root video 81, 0 Nov 26 12:40 /dev/video1
crw-rw---- 1 root video 81, 1 Nov 26 12:40 /dev/video2

### enabling microk8s addons: 
Addon dns is already enabled.
Addon helm3 is already enabled.
Addon rbac is already enabled.
Addon dashboard is already enabled.

### install akri chart: 
akri-helm-charts	https://deislabs.github.io/akri/

### waiting for installed chart to get ready: 
deployment.apps/akri-controller-deployment condition met

### get akri configuration: 
NAME              CAPACITY   AGE
akri-udev-video   1          31m

### install video streaming app: 
deployment.apps/akri-video-streaming-app unchanged
service/akri-video-streaming-app unchanged
deployment.apps/akri-video-streaming-app condition met

### get pods --all-namespaces: 
NAMESPACE     NAME                                          READY   STATUS    RESTARTS   AGE   IP            NODE            NOMINATED NODE   READINESS GATES
kube-system   calico-node-hbzcs                             1/1     Running   2          53m   10.128.0.44   microk8s-akri   <none>           <none>
kube-system   metrics-server-8bbfb4bdb-vm9zn                1/1     Running   0          32m   10.1.54.68    microk8s-akri   <none>           <none>
kube-system   coredns-86f78bb79c-dhwvp                      1/1     Running   0          32m   10.1.54.67    microk8s-akri   <none>           <none>
kube-system   calico-kube-controllers-847c8c99d-9dn98       1/1     Running   1          53m   10.1.54.66    microk8s-akri   <none>           <none>
kube-system   kubernetes-dashboard-7ffd448895-9jh65         1/1     Running   0          32m   10.1.54.69    microk8s-akri   <none>           <none>
kube-system   dashboard-metrics-scraper-6c4568dc68-ch6vk    1/1     Running   0          32m   10.1.54.70    microk8s-akri   <none>           <none>
default       akri-agent-daemonset-qq2h5                    1/1     Running   0          31m   10.128.0.44   microk8s-akri   <none>           <none>
default       akri-controller-deployment-5b4bb5cbb5-xt2sw   1/1     Running   0          31m   10.1.54.71    microk8s-akri   <none>           <none>
default       akri-udev-video-018417-pod                    1/1     Running   0          31m   10.1.54.72    microk8s-akri   <none>           <none>
default       akri-udev-video-aa247f-pod                    1/1     Running   0          31m   10.1.54.73    microk8s-akri   <none>           <none>
default       akri-video-streaming-app-fd5f4cb7d-2r9lb      1/1     Running   0          30m   10.1.54.74    microk8s-akri   <none>           <none>

### get daemonsets --all-namespaces: 
NAMESPACE     NAME                   DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE   CONTAINERS    IMAGES                                   SELECTOR
kube-system   calico-node            1         1         1       1            1           kubernetes.io/os=linux   53m   calico-node   calico/node:v3.13.2                      k8s-app=calico-node
default       akri-agent-daemonset   1         1         1       1            1           kubernetes.io/os=linux   31m   akri-agent    ghcr.io/deislabs/akri/agent:latest-dev   name=akri-agent

### get services --all-namespaces: 
NAMESPACE     NAME                         TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                  AGE   SELECTOR
default       kubernetes                   ClusterIP   10.152.183.1     <none>        443/TCP                  53m   <none>
kube-system   kube-dns                     ClusterIP   10.152.183.10    <none>        53/UDP,53/TCP,9153/TCP   32m   k8s-app=kube-dns
kube-system   metrics-server               ClusterIP   10.152.183.89    <none>        443/TCP                  32m   k8s-app=metrics-server
kube-system   kubernetes-dashboard         ClusterIP   10.152.183.42    <none>        443/TCP                  32m   k8s-app=kubernetes-dashboard
kube-system   dashboard-metrics-scraper    ClusterIP   10.152.183.248   <none>        8000/TCP                 32m   k8s-app=dashboard-metrics-scraper
default       akri-udev-video-018417-svc   ClusterIP   10.152.183.226   <none>        80/TCP                   30m   akri.sh/instance=akri-udev-video-018417,controller=akri.sh
default       akri-udev-video-svc          ClusterIP   10.152.183.227   <none>        80/TCP                   30m   akri.sh/configuration=akri-udev-video,controller=akri.sh
default       akri-udev-video-aa247f-svc   ClusterIP   10.152.183.133   <none>        80/TCP                   30m   akri.sh/instance=akri-udev-video-aa247f,controller=akri.sh
default       akri-video-streaming-app     NodePort    10.152.183.54    <none>        80:30813/TCP             30m   app=akri-video-streaming-app
Akri dashboard ports - gce:  80 - local: 12321 
K8s dashboard ports - gce:  443 - local: 3443 
<html>
  <head>
    <title>Akri Demo</title>
  </head>
  <body>
    <div style="max-width: 800px;  margin: auto;text-align:center">
      <h1>Akri Demo</h1>
      <div style="display: inline-block;clear:both;margin-bottom:30px">
        <img src="/camera_frame_feed/0" style="width:480px">
      </div>
      <ul style="display: block;list-style-type: none;padding:0;">
        
        <li style="display: inline-block; padding: 0 25">
          <img src="/camera_frame_feed/1" style="width:200px">
        </li>
        
        <li style="display: inline-block; padding: 0 25">
          <img src="/camera_frame_feed/2" style="width:200px">
        </li>
        
      </ul>
    </div>
  </body>
</html>gcloud command for access to K8s & Akri dashboards gcloud compute ssh microk8s-akri --zone=us-central1-c  --project=$GCP_PROJECT  --ssh-flag='-L 3443:localhost:3443 -L 12321:localhost:12321'
use authentication token: Mk9XemZ6bTRqdi9iSjRPV2ZBSTFqaFNZNU1tSnFHNVh2UmdUMEhpcEh0az0K
k8s dashboard: https://localhost:3443 - akri dashboard:  https://localhost:12321
akri dashboard:  http://localhost:12321

### load kernel module v4l2loopback: 

### check required kernel modules: 
videodev              225280  5 v4l2loopback
mc                     53248  1 videodev
v4l2loopback           40960  4
videodev              225280  5 v4l2loopback
vermagic:       5.4.0-1029-gcp SMP mod_unload 

### check devices: 
crw-rw---- 1 root video 81, 0 Nov 26 12:40 /dev/video1
crw-rw---- 1 root video 81, 1 Nov 26 12:40 /dev/video2

### enabling microk8s addons: 
Addon dns is already enabled.
Addon helm3 is already enabled.
Addon rbac is already enabled.
Addon dashboard is already enabled.

### install akri chart: 
akri-helm-charts	https://deislabs.github.io/akri/

### waiting for installed chart to get ready: 
deployment.apps/akri-controller-deployment condition met

### get akri configuration: 
NAME              CAPACITY   AGE
akri-udev-video   1          38m

### install video streaming app: 
deployment.apps/akri-video-streaming-app unchanged
service/akri-video-streaming-app unchanged
deployment.apps/akri-video-streaming-app condition met

### get pods --all-namespaces: 
NAMESPACE     NAME                                          READY   STATUS    RESTARTS   AGE   IP            NODE            NOMINATED NODE   READINESS GATES
kube-system   calico-node-hbzcs                             1/1     Running   2          60m   10.128.0.44   microk8s-akri   <none>           <none>
kube-system   metrics-server-8bbfb4bdb-vm9zn                1/1     Running   0          39m   10.1.54.68    microk8s-akri   <none>           <none>
kube-system   coredns-86f78bb79c-dhwvp                      1/1     Running   0          40m   10.1.54.67    microk8s-akri   <none>           <none>
kube-system   calico-kube-controllers-847c8c99d-9dn98       1/1     Running   1          60m   10.1.54.66    microk8s-akri   <none>           <none>
kube-system   kubernetes-dashboard-7ffd448895-9jh65         1/1     Running   0          39m   10.1.54.69    microk8s-akri   <none>           <none>
kube-system   dashboard-metrics-scraper-6c4568dc68-ch6vk    1/1     Running   0          39m   10.1.54.70    microk8s-akri   <none>           <none>
default       akri-agent-daemonset-qq2h5                    1/1     Running   0          38m   10.128.0.44   microk8s-akri   <none>           <none>
default       akri-controller-deployment-5b4bb5cbb5-xt2sw   1/1     Running   0          38m   10.1.54.71    microk8s-akri   <none>           <none>
default       akri-udev-video-018417-pod                    1/1     Running   0          38m   10.1.54.72    microk8s-akri   <none>           <none>
default       akri-udev-video-aa247f-pod                    1/1     Running   0          38m   10.1.54.73    microk8s-akri   <none>           <none>
default       akri-video-streaming-app-fd5f4cb7d-2r9lb      1/1     Running   0          37m   10.1.54.74    microk8s-akri   <none>           <none>

### get daemonsets --all-namespaces: 
NAMESPACE     NAME                   DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE   CONTAINERS    IMAGES                                   SELECTOR
kube-system   calico-node            1         1         1       1            1           kubernetes.io/os=linux   60m   calico-node   calico/node:v3.13.2                      k8s-app=calico-node
default       akri-agent-daemonset   1         1         1       1            1           kubernetes.io/os=linux   38m   akri-agent    ghcr.io/deislabs/akri/agent:latest-dev   name=akri-agent

### get services --all-namespaces: 
NAMESPACE     NAME                         TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                  AGE   SELECTOR
default       kubernetes                   ClusterIP   10.152.183.1     <none>        443/TCP                  60m   <none>
kube-system   kube-dns                     ClusterIP   10.152.183.10    <none>        53/UDP,53/TCP,9153/TCP   40m   k8s-app=kube-dns
kube-system   metrics-server               ClusterIP   10.152.183.89    <none>        443/TCP                  39m   k8s-app=metrics-server
kube-system   kubernetes-dashboard         ClusterIP   10.152.183.42    <none>        443/TCP                  39m   k8s-app=kubernetes-dashboard
kube-system   dashboard-metrics-scraper    ClusterIP   10.152.183.248   <none>        8000/TCP                 39m   k8s-app=dashboard-metrics-scraper
default       akri-udev-video-018417-svc   ClusterIP   10.152.183.226   <none>        80/TCP                   38m   akri.sh/instance=akri-udev-video-018417,controller=akri.sh
default       akri-udev-video-svc          ClusterIP   10.152.183.227   <none>        80/TCP                   38m   akri.sh/configuration=akri-udev-video,controller=akri.sh
default       akri-udev-video-aa247f-svc   ClusterIP   10.152.183.133   <none>        80/TCP                   38m   akri.sh/instance=akri-udev-video-aa247f,controller=akri.sh
default       akri-video-streaming-app     NodePort    10.152.183.54    <none>        80:30813/TCP             37m   app=akri-video-streaming-app
Akri dashboard ports - gce:  80 - local: 12321 
K8s dashboard ports - gce:  443 - local: 3443 
<html>
  <head>
    <title>Akri Demo</title>
  </head>
  <body>
    <div style="max-width: 800px;  margin: auto;text-align:center">
      <h1>Akri Demo</h1>
      <div style="display: inline-block;clear:both;margin-bottom:30px">
        <img src="/camera_frame_feed/0" style="width:480px">
      </div>
      <ul style="display: block;list-style-type: none;padding:0;">
        
        <li style="display: inline-block; padding: 0 25">
          <img src="/camera_frame_feed/1" style="width:200px">
        </li>
        
        <li style="display: inline-block; padding: 0 25">
          <img src="/camera_frame_feed/2" style="width:200px">
        </li>
        
      </ul>
    </div>
  </body>
</html>gcloud command for access to K8s & Akri dashboards gcloud compute ssh microk8s-akri --zone=us-central1-c  --project=$GCP_PROJECT  --ssh-flag='-L 3443:localhost:3443 -L 12321:localhost:12321'
use authentication token: Mk9XemZ6bTRqdi9iSjRPV2ZBSTFqaFNZNU1tSnFHNVh2UmdUMEhpcEh0az0K
k8s dashboard: https://localhost:3443 - akri dashboard:  https://localhost:12321
akri dashboard:  http://localhost:12321

### load kernel module v4l2loopback: 

### check required kernel modules: 
videodev              225280  5 v4l2loopback
mc                     53248  1 videodev
v4l2loopback           40960  4
videodev              225280  5 v4l2loopback
vermagic:       5.4.0-1029-gcp SMP mod_unload 

### check devices: 
crw-rw---- 1 root video 81, 0 Nov 26 12:40 /dev/video1
crw-rw---- 1 root video 81, 1 Nov 26 12:40 /dev/video2

### enabling microk8s addons: 
Addon dns is already enabled.
Addon helm3 is already enabled.
Addon rbac is already enabled.
Addon dashboard is already enabled.

### install akri chart: 
akri-helm-charts	https://deislabs.github.io/akri/

### waiting for installed chart to get ready: 
deployment.apps/akri-controller-deployment condition met

### get akri configuration: 
NAME              CAPACITY   AGE
akri-udev-video   1          44m

### install video streaming app: 
deployment.apps/akri-video-streaming-app unchanged
service/akri-video-streaming-app unchanged
deployment.apps/akri-video-streaming-app condition met

### get pods --all-namespaces: 
NAMESPACE     NAME                                          READY   STATUS    RESTARTS   AGE   IP            NODE            NOMINATED NODE   READINESS GATES
kube-system   calico-node-hbzcs                             1/1     Running   2          66m   10.128.0.44   microk8s-akri   <none>           <none>
kube-system   metrics-server-8bbfb4bdb-vm9zn                1/1     Running   0          45m   10.1.54.68    microk8s-akri   <none>           <none>
kube-system   coredns-86f78bb79c-dhwvp                      1/1     Running   0          46m   10.1.54.67    microk8s-akri   <none>           <none>
kube-system   calico-kube-controllers-847c8c99d-9dn98       1/1     Running   1          66m   10.1.54.66    microk8s-akri   <none>           <none>
kube-system   kubernetes-dashboard-7ffd448895-9jh65         1/1     Running   0          45m   10.1.54.69    microk8s-akri   <none>           <none>
kube-system   dashboard-metrics-scraper-6c4568dc68-ch6vk    1/1     Running   0          45m   10.1.54.70    microk8s-akri   <none>           <none>
default       akri-agent-daemonset-qq2h5                    1/1     Running   0          44m   10.128.0.44   microk8s-akri   <none>           <none>
default       akri-controller-deployment-5b4bb5cbb5-xt2sw   1/1     Running   0          44m   10.1.54.71    microk8s-akri   <none>           <none>
default       akri-udev-video-018417-pod                    1/1     Running   0          44m   10.1.54.72    microk8s-akri   <none>           <none>
default       akri-udev-video-aa247f-pod                    1/1     Running   0          44m   10.1.54.73    microk8s-akri   <none>           <none>
default       akri-video-streaming-app-fd5f4cb7d-2r9lb      1/1     Running   0          43m   10.1.54.74    microk8s-akri   <none>           <none>

### get daemonsets --all-namespaces: 
NAMESPACE     NAME                   DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE   CONTAINERS    IMAGES                                   SELECTOR
kube-system   calico-node            1         1         1       1            1           kubernetes.io/os=linux   66m   calico-node   calico/node:v3.13.2                      k8s-app=calico-node
default       akri-agent-daemonset   1         1         1       1            1           kubernetes.io/os=linux   44m   akri-agent    ghcr.io/deislabs/akri/agent:latest-dev   name=akri-agent

### get services --all-namespaces: 
NAMESPACE     NAME                         TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                  AGE   SELECTOR
default       kubernetes                   ClusterIP   10.152.183.1     <none>        443/TCP                  66m   <none>
kube-system   kube-dns                     ClusterIP   10.152.183.10    <none>        53/UDP,53/TCP,9153/TCP   46m   k8s-app=kube-dns
kube-system   metrics-server               ClusterIP   10.152.183.89    <none>        443/TCP                  45m   k8s-app=metrics-server
kube-system   kubernetes-dashboard         ClusterIP   10.152.183.42    <none>        443/TCP                  45m   k8s-app=kubernetes-dashboard
kube-system   dashboard-metrics-scraper    ClusterIP   10.152.183.248   <none>        8000/TCP                 45m   k8s-app=dashboard-metrics-scraper
default       akri-udev-video-018417-svc   ClusterIP   10.152.183.226   <none>        80/TCP                   44m   akri.sh/instance=akri-udev-video-018417,controller=akri.sh
default       akri-udev-video-svc          ClusterIP   10.152.183.227   <none>        80/TCP                   44m   akri.sh/configuration=akri-udev-video,controller=akri.sh
default       akri-udev-video-aa247f-svc   ClusterIP   10.152.183.133   <none>        80/TCP                   44m   akri.sh/instance=akri-udev-video-aa247f,controller=akri.sh
default       akri-video-streaming-app     NodePort    10.152.183.54    <none>        80:30813/TCP             43m   app=akri-video-streaming-app
Akri dashboard ports - gce:  80 - local: 12321 
K8s dashboard ports - gce:  443 - local: 3443 
<html>
  <head>
    <title>Akri Demo</title>
  </head>
  <body>
    <div style="max-width: 800px;  margin: auto;text-align:center">
      <h1>Akri Demo</h1>
      <div style="display: inline-block;clear:both;margin-bottom:30px">
        <img src="/camera_frame_feed/0" style="width:480px">
      </div>
      <ul style="display: block;list-style-type: none;padding:0;">
        
        <li style="display: inline-block; padding: 0 25">
          <img src="/camera_frame_feed/1" style="width:200px">
        </li>
        
        <li style="display: inline-block; padding: 0 25">
          <img src="/camera_frame_feed/2" style="width:200px">
        </li>
        
      </ul>
    </div>
  </body>
</html>gcloud command for access to K8s & Akri dashboards gcloud compute ssh microk8s-akri --zone=us-central1-c  --project=$GCP_PROJECT  --ssh-flag='-L 3443:localhost:3443 -L 12321:localhost:12321'
use authentication token: Mk9XemZ6bTRqdi9iSjRPV2ZBSTFqaFNZNU1tSnFHNVh2UmdUMEhpcEh0az0K
k8s dashboard: https://localhost:3443 - akri dashboard:  https://localhost:12321
akri dashboard:  http://localhost:12321
```
## Akri Helm Chart
```
version.BuildInfo{Version:"v3.4.1", GitCommit:"c4e74854886b2efe3321e185578e6db9be0a6e29", GitTreeState:"clean", GoVersion:"go1.14.11"}
---
# Source: akri-dev/templates/rbac.yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: akri-controller-sa
---
# Source: akri-dev/templates/rbac.yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: akri-agent-sa
---
# Source: akri-dev/templates/rbac.yaml
kind: ClusterRole
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  name: "akri-controller-role"
rules:
- apiGroups: [""]
  resources: ["pods", "services"]
  verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
- apiGroups: [""]
  resources: ["nodes"]
  verbs: ["get", "list", "watch"]
- apiGroups: ["akri.sh"]
  resources: ["instances"]
  verbs: ["get", "list", "watch", "update", "patch"]
- apiGroups: ["akri.sh"]
  resources: ["configurations"]
  verbs: ["get", "list", "watch"]
---
# Source: akri-dev/templates/rbac.yaml
kind: ClusterRole
apiVersion: rbac.authorization.k8s.io/v1beta1
metadata:
  name: "akri-agent-role"
rules:
- apiGroups: [""]
  resources: ["pods"]
  verbs: ["get", "list", "watch"]
- apiGroups: ["akri.sh"]
  resources: ["instances"]
  verbs: ["get", "list", "watch", "create", "update", "patch", "delete"]
- apiGroups: ["akri.sh"]
  resources: ["configurations"]
  verbs: ["get", "list", "watch"]
---
# Source: akri-dev/templates/rbac.yaml
apiVersion: 'rbac.authorization.k8s.io/v1'
kind: 'ClusterRoleBinding'
metadata:
  name: 'akri-controller-binding'
  namespace: default
roleRef:
  apiGroup: ''
  kind: 'ClusterRole'
  name: 'akri-controller-role'
subjects:
  - kind: 'ServiceAccount'
    name: 'akri-controller-sa'
    namespace: default
---
# Source: akri-dev/templates/rbac.yaml
apiVersion: 'rbac.authorization.k8s.io/v1'
kind: 'ClusterRoleBinding'
metadata:
  name: 'akri-agent-binding'
  namespace: default
roleRef:
  apiGroup: ''
  kind: 'ClusterRole'
  name: 'akri-agent-role'
subjects:
  - kind: 'ServiceAccount'
    name: 'akri-agent-sa'
    namespace: default
---
# Source: akri-dev/templates/agent.yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: akri-agent-daemonset
spec:
  selector:
    matchLabels:
      name: akri-agent
  template:
    metadata:
      labels:
        name: akri-agent
    spec:
      hostNetwork: true
      dnsPolicy: ClusterFirstWithHostNet
      nodeSelector:
        "kubernetes.io/os": linux
      serviceAccountName: 'akri-agent-sa'
      containers:
      - name: akri-agent
        image: "ghcr.io/deislabs/akri/agent:v0.0.43-dev"
        imagePullPolicy: Always
        env:
          - name: HOST_CRICTL_PATH
            value: /host/usr/bin/crictl
          - name: HOST_RUNTIME_ENDPOINT
            value: unix:///host/var/run/dockershim.sock
          - name: HOST_IMAGE_ENDPOINT
            value: unix:///host/var/run/dockershim.sock
          - name: AGENT_NODE_NAME
            valueFrom:
              fieldRef:
                fieldPath: spec.nodeName
        volumeMounts:
          - name: device-plugin
            mountPath: /var/lib/kubelet/device-plugins
          - name: usr-bin-crictl
            mountPath: /host/usr/bin/crictl
          - name: var-run-dockershim
            mountPath: /host/var/run/dockershim.sock
          - name: devices
            mountPath: /run/udev
        securityContext:
          privileged: true
      volumes:
      - name: device-plugin
        hostPath:
          path: "/var/lib/kubelet/device-plugins"
      - name: usr-bin-crictl
        hostPath:
          path: "/usr/bin/crictl"
      - name: var-run-dockershim
        hostPath:
          path: "/var/run/dockershim.sock"
      - name: devices
        hostPath:
          path: "/run/udev"
---
# Source: akri-dev/templates/controller.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: akri-controller-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: akri-controller
  template:
    metadata:
      labels:
        app: akri-controller
    spec:
      serviceAccountName: 'akri-controller-sa'
      containers:
      - name: akri-controller
        image: "ghcr.io/deislabs/akri/controller:v0.0.43-dev"
        imagePullPolicy: Always
      tolerations:
        # Allow this pod to run on the master.
        - key: node-role.kubernetes.io/master
          effect: NoSchedule
      nodeSelector:
        "kubernetes.io/os": linux
```
