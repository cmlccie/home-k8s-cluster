# --------------------------------------------------------------------------------------
# NGINX Ingress Controller
# --------------------------------------------------------------------------------------

resource "helm_release" "nginx_ingress" {
  name = "nginx-ingress"

  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"

  values = ["${file("values/nginx_ingress.yaml")}"]
}
