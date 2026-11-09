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
  type        = list(string)
}

variable "repo_visibility" {
  description = "Repository visibility"
  type        = string
}

variable "github_app_id" {
  description = "GitHub App ID"
  type        = string
}

variable "tier" {
  description = "Cordon tier"
  type        = string
}

variable "solution_definitions_release_tag" {
  description = "Solution definitions release tag"
  type        = string
}

variable "ruleset_enforcement" {
  type    = string
  default = "disabled"

  validation {
    condition     = contains(["disabled", "active"], var.ruleset_enforcement)
    error_message = "Ruleset enforcement must be disabled or active."
  }
}