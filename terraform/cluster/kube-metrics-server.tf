# --------------------------------------------------------------------------------------
# Kubernetes Metrics Server
# --------------------------------------------------------------------------------------

resource "helm_release" "kubernetes_metrics_server" {
  name = "metrics-server"

  namespace        = "kube-system"
  create_namespace = false

  repository = "https://kubernetes-sigs.github.io/metrics-server/"
  chart      = "metrics-server"
  version    = "3.12.1"

  set {
    name  = "args[0]"
    value = "--kubelet-preferred-address-types=InternalIP"
  }

  set {
    name  = "args[1]"
    value = "--kubelet-insecure-tls"
  }

  timeout = 60
}
