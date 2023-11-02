# --------------------------------------------------------------------------------------
# Kubernetes Dashboard
# --------------------------------------------------------------------------------------

resource "helm_release" "kubernetes_dashboard" {
  name = "kubernetes-dashboard"

  namespace        = "kubernetes-dashboard"
  create_namespace = true

  repository = "https://kubernetes.github.io/dashboard/"
  chart      = "kubernetes-dashboard"

  values = ["${file("values/kubernetes_dashboard.yaml")}"]
}

resource "kubernetes_service" "kubernetes_dashboard" {
  metadata {
    name      = "kubernetes-dashboard-test"
    namespace = "kubernetes-dashboard"
  }

  spec {
    type = "LoadBalancer"

    ip_families      = ["IPv4", "IPv6"]
    ip_family_policy = "PreferDualStack"

    selector = {
      "app.kubernetes.io/name" = "kubernetes-dashboard"
    }

    port {
      port        = 443
      target_port = 8443
    }
  }
}
