terraform {
  cloud {
    hostname     = "app.terraform.io"
    organization = "example-org-41e326"
    workspaces {
      name = "mc-app-test"
    }
  }

  required_providers {
    vercel = {
      source  = "vercel/vercel"
      version = "~> 0.11.4"
    }
  }
}

variable "is_prod" {
  description = "If false, deploys preview environment"
  default     = false
}

module "preview_env" {
  source  = "./preview-env"
  is_prod = var.is_prod
}

output "preview_url" {
  value = module.preview_env.preview_url
}