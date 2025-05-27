variable "services" {
  type    = list(string)
  default = ["api", "worker", "cron"]
}

variable "enable_cleanup" {
  type    = bool
  default = true
}

variable "enable_sidecars" {
  type    = bool
  default = true
}

locals {
  services = {
    for s in var.services : s => {
      critical = contains(["api", "worker"], s)
    }
  }

  cleanup_targets = [for k, v in local.services : k if v.critical]
}

module "services" {
  for_each = local.services

  source  = "./modules/service"
  name    = each.key
  critical = each.value.critical
}

module "sidecars" {
  count  = var.enable_sidecars ? length(var.services) : 0
  source = "./modules/sidecar"

  service_name = var.services[count.index]
  depends_on   = [module.services[var.services[count.index]]]
}

resource "null_resource" "cleanup" {
  count = var.enable_cleanup ? 1 : 0

  triggers = {
    services = join(",", local.cleanup_targets)
  }

  depends_on = [
    for svc in local.cleanup_targets : module.services[svc].id
  ]
}

output "service_ids" {
  value = [for s in values(module.services) : s.id]
}