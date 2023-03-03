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

data "vercel_project_directory" "build_path" {
  path = "public"
}
resource "vercel_project" "mc_app_prod" {
  name      = "mc-app-prod"
}

resource "vercel_project" "mc_app_staging" {
  name      = "mc-app-staging"
}

resource "vercel_deployment" "mc_custom_app" {
  project_id  = var.is_prod ? vercel_project.mc_app_prod.id : vercel_project.mc_app_staging.id
  files       = data.vercel_project_directory.build_path.files
  path_prefix = "public"
  production  = true
}
output "preview_url" {
  value = vercel_deployment.mc_custom_app.url
}