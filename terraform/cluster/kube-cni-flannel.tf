# -------------------------------------------------------------------------------------------------
# flannel Pod Networking (CNI)
# -------------------------------------------------------------------------------------------------

resource "helm_release" "flannel" {
  name = "flannel"

  namespace        = "kube-cni-flannel"
  create_namespace = true

  repository = "https://flannel-io.github.io/flannel/"
  chart      = "flannel"
  version    = "v0.25.6"

  set {
    name  = "podCidr"
    value = "10.1.0.0/16"
  }

  set {
    name  = "podCidrv6"
    value = "fd6d:a591:2efb:100::/56"
  }
}
