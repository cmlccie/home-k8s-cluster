# -------------------------------------------------------------------------------------------------
# MetalLB
# -------------------------------------------------------------------------------------------------

resource "kubernetes_namespace" "metallb" {
  metadata {
    name = "metallb-system"
    labels = {
      "pod-security.kubernetes.io/enforce" = "privileged"
      "pod-security.kubernetes.io/audit"   = "privileged"
      "pod-security.kubernetes.io/warn"    = "privileged"
    }
  }
}

resource "helm_release" "metallb" {
  name = "metallb"

  namespace = one(kubernetes_namespace.metallb.metadata[*].name)

  repository = "https://metallb.github.io/metallb"
  chart      = "metallb"
}

# --------------------------------------------------------------------------------------
# IP Address Pool
# --------------------------------------------------------------------------------------

locals {
  metallb_ip_address_pools = {
    default = [
      "172.28.2.80-172.28.2.89",
    ]
  }
}

resource "kubernetes_manifest" "metallb_ip_address_pool" {
  for_each = local.metallb_ip_address_pools

  manifest = {
    "apiVersion" = "metallb.io/v1beta1"
    "kind"       = "IPAddressPool"
    "metadata" = {
      "name"      = "ip-address-pool-${each.key}"
      "namespace" = "metallb-system"
    }
    "spec" = {
      "addresses" = each.value
    }
  }
}

# --------------------------------------------------------------------------------------
# L2 Advertisement
# --------------------------------------------------------------------------------------

resource "kubernetes_manifest" "l2advertisement_metallb_system_example" {
  manifest = {
    "apiVersion" = "metallb.io/v1beta1"
    "kind"       = "L2Advertisement"
    "metadata" = {
      "name"      = "example"
      "namespace" = "metallb-system"
    }
  }
}
