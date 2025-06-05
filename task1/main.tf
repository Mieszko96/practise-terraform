resource "null_resource" "example" {
  triggers = {
    env = var.env_name
  }

  provisioner "local-exec" {
    command = "echo Environment is ${self.triggers.env}"
  }
}

output "region_info" {
  value = "Deploying to ${var.region}"
}

resource "null_resource" "do_create" {
  count = var.do_create ? 1 : 0 
}