# --------------------------------------------------------------------------------------
# Certificate Manager
# --------------------------------------------------------------------------------------

resource "helm_release" "cert_manager" {
  name = "cert-manager"

  namespace        = "cert-manager"
  create_namespace = true

  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = "v1.15.3"

  set {
    name  = "crds.enabled"
    value = "true"
  }
}
