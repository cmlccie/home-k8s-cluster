# -------------------------------------------------------------------------------------------------
# flannel Pod Networking (CNI)
# -------------------------------------------------------------------------------------------------

resource "helm_release" "example" {
  name = "flannel"

  namespace        = "kube-flannel"
  create_namespace = true

  repository = "https://flannel-io.github.io/flannel/"
  chart      = "flannel"
  version    = "v0.22.3"

  set {
    name  = "podCidr"
    value = "10.244.0.0/16"
  }
}
