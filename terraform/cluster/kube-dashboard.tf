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
