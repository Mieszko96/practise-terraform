variable "service_name" {
  type = string
}

resource "null_resource" "sidecar" {
  triggers = {
    attached_to = var.service_name
  }
}
