# Kubernetes Vagrant

This repository code allows you to create a single master kubernetes cluster with any number of worker nodes.
Its a single command Vagrant up to setup full kubernetes play environment in a laptop.

## Pre-Requisites

- Vagrant
- VirtualBox 6.x


## Start Cluster

Provision cluster with single command `vagrant up`.
Access the any of the nodes with `vagrant ssh <admin/master/node1/node2>`
Run kubectl commands on master as root `kubectl get nodes`


## Dynamic NFS PV Storage

Dynamic NFS pv provisioning help creating PVs dynamically when a PVC is created. All PVs are created on NFS server
and PVC must add a annotation to indicate the storage class. Following example shows how to create PVC using
the dynamic nfs PV provisioning.

On the master node as root create file `/tmp/my-pvc.yaml` with content:
```yaml
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: my-pvc
  annotations:
    volume.beta.kubernetes.io/storage-class: "nfs-storage"
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Mi
```

On the master node as root run `kubectl apply -f /tmp/my-pvc.yaml` to create the pvc.
Check the pvc is created and bound with command `kubectl get pvc`. Check on admin VM at /nfs
new folder created for the PV.
