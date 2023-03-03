variable "environment_tag" {
  description = "Environment tag"
  default     = "Learn"
}

variable "is_prod" {
  description = "If false, deploys preview environment"
  default     = false
}