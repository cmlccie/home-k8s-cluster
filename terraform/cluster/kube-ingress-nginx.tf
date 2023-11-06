# --------------------------------------------------------------------------------------
# NGINX Ingress Controllers
# --------------------------------------------------------------------------------------

resource "kubernetes_namespace" "kube_ingress_nginx" {
  metadata {
    name = "kube-ingress-nginx"
  }
}

# --------------------------------------------------------------------------------------
# Internal Ingress
# --------------------------------------------------------------------------------------


resource "helm_release" "ingress_nginx_internal" {
  name = "ingress-nginx-internal"

  namespace = one(kubernetes_namespace.kube_ingress_nginx.metadata[*].name)

  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"

  values = ["${file("values/ingress-nginx-internal.yaml")}"]

  timeout = 60
  depends_on = [
    helm_release.metallb,
    kubernetes_manifest.metallb_ip_address_pool,
  ]
}


# --------------------------------------------------------------------------------------
# External Ingress
# --------------------------------------------------------------------------------------


resource "helm_release" "ingress_nginx_external" {
  name = "ingress-nginx-external"

  namespace = one(kubernetes_namespace.kube_ingress_nginx.metadata[*].name)

  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"

  values = ["${file("values/ingress-nginx-external.yaml")}"]

  timeout = 60
  depends_on = [
    helm_release.metallb,
    kubernetes_manifest.metallb_ip_address_pool,
  ]
}
