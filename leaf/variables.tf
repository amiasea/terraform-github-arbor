variable "repo_name_prefix" {
  description = "Prefix applied to the repository name."
  type        = string
}

variable "repo_name" {
  description = "Name of the leaf repository."
  type        = string
}

variable "aspect_options" {
  description = "Aspect options"
  type          = list(string)
}

variable "repo_visibility" {
  description = "Repository visibility"
  type = string
}

variable "github_app_id" {
  description = "GitHub App ID"
  type        = string
}