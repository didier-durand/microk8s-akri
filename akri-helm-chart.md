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
