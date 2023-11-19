# -------------------------------------------------------------------------------------------------
# External DNS
# -------------------------------------------------------------------------------------------------

resource "kubernetes_namespace" "kube_dns_external" {
  metadata {
    name = "kube-dns-external"
  }
}


# --------------------------------------------------------------------------------------
# Pi-Hole
# --------------------------------------------------------------------------------------

resource "helm_release" "external_dns_pihole" {
  name             = "external-dns-pihole"
  namespace        = one(kubernetes_namespace.kube_dns_external.metadata[*].name)
  create_namespace = false
  repository       = "https://kubernetes-sigs.github.io/external-dns/"
  chart            = "external-dns"
  values           = [file("${path.module}/values/dns-external-pihole.yaml")]
}


# --------------------------------------------------------------------------------------
# AWS Route53
# --------------------------------------------------------------------------------------

resource "helm_release" "external_dns_route53" {
  name             = "external-dns-route53"
  namespace        = one(kubernetes_namespace.kube_dns_external.metadata[*].name)
  create_namespace = false
  repository       = "https://kubernetes-sigs.github.io/external-dns/"
  chart            = "external-dns"
  values           = [file("${path.module}/values/dns-external-route53.yaml")]
}
