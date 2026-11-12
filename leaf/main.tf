resource "github_repository" "this" {
  name       = "${var.repo_name_prefix}-${var.repo_name}"
  auto_init  = true
  visibility = var.repo_visibility
}

resource "github_repository_custom_property" "aspect_options" {
  repository    = github_repository.this.name
  property_name = "aspect_options"
  property_type = "string"

  property_value = [join(",", var.aspect_options)]
}

resource "github_repository_custom_property" "tier" {
  repository    = github_repository.this.name
  property_name = "tier"
  property_type = "string"

  property_value = toset([var.tier])
}

resource "github_repository_file" "pull_request" {
  repository          = github_repository.this.name
  branch              = "main"
  file                = ".github/workflows/pull_request.yml"
  content             = templatefile("${path.module}/pull_request.yml.tmpl", {
    pomology_flora_release_tag = var.pomology_flora_release_tag
  })
  commit_message      = "Add composition validation workflow"
  overwrite_on_create = true
}

resource "github_branch" "source" {
  repository    = github_repository.this.name
  branch        = "development"
  source_branch = "main"

  depends_on = [
    github_repository_file.pull_request
  ]
}