variable "github_organization_name" {
  description = "Name of the GitHub Organization"
  type = string
}

variable "repo_name_prefix" {
  description = "Prefix applied to every managed repository name."
  type        = string
}

variable "repo_visibility" {
  description = "Repository visibility"
  type        = string
  default     = "public"
}

variable "github_app_id" {
  description = "GitHub App ID"
  type        = string
}

variable "pomology" {
  type = object({
    varieties = list(string)

    cordons = map(object({
      tier = string
      leaves = map(object({
        options = map(string)
      }))
    }))
  })
}