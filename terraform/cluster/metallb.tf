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

  depends_on = [helm_release.flannel]
}

# --------------------------------------------------------------------------------------
# IP Address Pool
# --------------------------------------------------------------------------------------

locals {
  metallb_ip_address_pools = {
    static = {
      autoAssign = false
      addresses = [
        "172.30.1.0/24",
        "2600:1700:5010:466a::/80",
      ]
    }
    default = {
      autoAssign = true
      addresses = [
        "172.30.2.0/24",
        "fddf:b7e0:ec01::/80",
      ]
    }
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
      "autoAssign" = each.value.autoAssign
      "addresses"  = each.value.addresses
    }
  }

  depends_on = [helm_release.metallb]
}

# --------------------------------------------------------------------------------------
# L2 Advertisement
# --------------------------------------------------------------------------------------

resource "kubernetes_manifest" "metallb_system_l2advertisement" {
  manifest = {
    "apiVersion" = "metallb.io/v1beta1"
    "kind"       = "L2Advertisement"
    "metadata" = {
      "name"      = "l2advertisement"
      "namespace" = "metallb-system"
    }
  }

  depends_on = [helm_release.metallb]
}
