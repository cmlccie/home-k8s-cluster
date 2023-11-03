# -------------------------------------------------------------------------------------------------
# NFS Subdir External Provisioners (CSI)
# -------------------------------------------------------------------------------------------------

resource "kubernetes_namespace" "kube_csi_nfs" {
  metadata {
    name = "kube-csi-nfs"
  }
}

locals {
  nfs_storage_classes = {
    "lh-nas01-ssd-rwo" = {
      nfs_path    = "/ssd-nfs/rwo"
      access_mode = "ReadWriteOnce"
      default     = true
    }
    "lh-nas01-ssd-rwm" = {
      nfs_path    = "/ssd-nfs/rwm"
      access_mode = "ReadWriteMany"
      default     = false
    }
    "lh-nas01-m2-rwo" = {
      nfs_path    = "/m2-nfs/rwo"
      access_mode = "ReadWriteOnce"
      default     = false
    }
    "lh-nas01-m2-rwm" = {
      nfs_path    = "/m2-nfs/rwm"
      access_mode = "ReadWriteMany"
      default     = false
    }
  }
}

resource "helm_release" "kube_csi_nfs" {
  for_each = local.nfs_storage_classes

  name = each.key

  namespace = one(kubernetes_namespace.kube_csi_nfs.metadata[*].name)

  repository = "https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/"
  chart      = "nfs-subdir-external-provisioner"

  set {
    name  = "nfs.server"
    value = "172.30.0.10"
  }

  set {
    name  = "nfs.path"
    value = each.value.nfs_path
  }

  set {
    name  = "storageClass.name"
    value = each.key
  }

  set {
    name  = "storageClass.provisionerName"
    value = "k8s-sigs.io/${each.key}"
  }

  set {
    name  = "storageClass.accessModes"
    value = each.value.access_mode
  }

  set {
    name  = "storageClass.defaultClass"
    value = each.value.default
  }

  depends_on = [helm_release.flannel]
}
