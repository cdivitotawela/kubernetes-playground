# Lab - Ingress
This lab helps to practice installing ingress-controllers in the Kubernetes cluster.

## Pre-Requisites
- Kube config configured for the cluster
- Helm CLI installed

## Ingress Controller Installation

### Create Namespace
First create namespace called `ingress`
```bashe
kubectl create namespace ingress
```

### Generate TLS certificate and Secret
In order to enable the https/tls, lets generate self-signed cert using the utility [generate-cert.sh](generate-cert.sh)
This generates files `web.kube.play-key.pem` `web.kube.play.csr` `web.kube.play.crt` and create tls secret `certificate`
in namespace `ingress`


### HA-Proxy Ingress Controller

```bash
helm repo add haproxytech https://haproxytech.github.io/helm-charts

# Our cluster node1 forward 30080 and 30443 ports to host machine
# We used this to setup ingress with NodePort

# Search ha-proxy helm chart name
helm search repo haproxy

# Install ha-proxy
helm install ingress-controller haproxytech/kubernetes-ingress \
     --namespace ingress \
     --values values.yaml
```

## Running Workload
Ingress match the request based on the hostname ie `Host` header in the request.
Either edit the hosts file to add an entry or use header `Host` in the request.

```bash
# Add following entry to /etc/hosts (Linux/Mac)
127.0.0.1   web.kube.play

# Apply the manifest
kubectl create namespace web
kubectl -n web apply -f manifest-web-server.yaml

# Access the web application vi browser. Need to accept the self-signed certificate warning
https://web.kube.play:30443/

# Access via command line
curl --insecure 'https://127.0.0.1:30443/' -H 'Host: web.kube.play'
curl --cacert web.kube.play.crt  'https://web.kube.play:30443/'
```
