# --------------------------------------------------------------------------------------
# NGINX Ingress Controller
# --------------------------------------------------------------------------------------

resource "helm_release" "ingress_nginx" {
  name = "ingress-nginx"

  namespace        = "kube-ingress-nginx"
  create_namespace = true

  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"

  values = ["${file("values/ingress-nginx.yaml")}"]

  timeout = 60
  depends_on = [
    helm_release.metallb,
    kubernetes_manifest.metallb_ip_address_pool,
  ]
}
