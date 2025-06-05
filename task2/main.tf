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