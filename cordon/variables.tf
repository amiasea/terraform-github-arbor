variable "repo_name_prefix" {
  description = "Prefix applied to the repository name."
  type        = string
}

variable "repo_name" {
  description = "Name of the superproject repository."
  type        = string
}

variable "repo_visibility" {
  description = "Repository visibility"
  type = string
}

variable "github_app_id" {
  description = "GitHub App ID"
  type        = string
}

variable "varieties" {
  description = "Varieties"
  type = list(string)
}

variable "aspect_options" {
  description = "Aspect Options"
  type = list(string)
}

variable "cordon" {
  description = "Cordon"
  type = object({
      tier = string
      leaves = map(object({
        options = map(string)
      }))
    })
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

variable "child_cordon_names" {
  description = "Names of Cordons whose tier identifies this Cordon as their parent."
  type        = list(string)
  default     = []
}