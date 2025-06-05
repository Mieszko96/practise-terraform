module "app" {
  source = "./modules/app"

  app_name = "my-service"
}

output "deployment_status" {
  value = module.app.status
}

output "instance_ips" {
  value = module.app.ips
}

resource "null_resource" "writer" {
  provisioner "local-exec" {
    command = "echo written_value > output.txt"
  }

  triggers = {
    always_run = "${timestamp()}"
  }
}

data "local_file" "reader" {
  filename = "output.txt"
}
