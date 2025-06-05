variable "env_name" {
  type = string
  description = "Environment name"

  validation {
    condition     = can(regex("^[a-zA-Z]+$", var.env_name))
    error_message = ""
  }
}

variable "region" {
  description = "Deployment region"
  type        = string
}

variable "do_create" {
  default = "yes"  
}
