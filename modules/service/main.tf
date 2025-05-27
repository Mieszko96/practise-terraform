variable "name" {
  type = string
}

variable "critical" {
  type = bool
}

locals {
  name = "shadowed"
}

resource "null_resource" "service" {
  triggers = {
    name     = var.name
    critical = tostring(var.critical)
  }
}

