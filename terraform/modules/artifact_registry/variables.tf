variable "project_id" {
  description = "Google Cloud project hosting the image repository."
  type        = string
}

variable "region" {
  description = "Region hosting the image repository."
  type        = string
}

variable "repository_name" {
  description = "Artifact Registry repository identifier."
  type        = string
}
