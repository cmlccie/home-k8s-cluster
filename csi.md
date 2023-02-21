# Container Storage Interface

## Kubernetes NFS Subdir External Provisioner

[GitHub Repository](https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner)
[Helm Chart Installation](https://github.com/kubernetes-sigs/nfs-subdir-external-provisioner/blob/master/charts/nfs-subdir-external-provisioner/README.md)

```shell
helm repo add nfs-subdir-external-provisioner https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/

helm install lh-nas01-nfs-rwo nfs-subdir-external-provisioner/nfs-subdir-external-provisioner \
    --set nfs.server=172.28.2.10 \
    --set nfs.path=/rpi-k8s/rwo \
    --set storageClass.accessModes=ReadWriteOnce \
    --set storageClass.name=lh-nas01-nfs-rwo \
    --set storageClass.provisionerName=k8s-sigs.io/lh-nas01-nfs-rwo

helm install lh-nas01-nfs-rwm nfs-subdir-external-provisioner/nfs-subdir-external-provisioner \
    --set nfs.server=172.28.2.10 \
    --set nfs.path=/rpi-k8s/rwm \
    --set storageClass.accessModes=ReadWriteMany \
    --set storageClass.name=lh-nas01-nfs-rwm \
    --set storageClass.provisionerName=k8s-sigs.io/lh-nas01-nfs-rwm
```
