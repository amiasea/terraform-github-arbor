variable "repo_name_prefix" {
  description = "Prefix applied to the repository name."
  type        = string
}

variable "repo_name" {
  description = "Name of the superproject repository."
  type        = string
}

variable "leaves" {
  description = "Direct leaf aspects and their variety-to-option mappings."

  type = map(object({
    options = map(string)
  }))
}
variable "repo_visibility" {
  description = "Repository visibility"
  type = string
}

variable "github_app_id" {
  description = "GitHub App ID"
  type        = string
}