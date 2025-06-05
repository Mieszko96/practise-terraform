resource "null_resource" "app" {
  count = var.replicas

  provisioner "local-exec" {
    command = "echo Deploying ${var.app_name} instance ${count.index + 1}"
  }
}

output "status" {
  value = "Deployment completed for ${var.app_name}"
}
