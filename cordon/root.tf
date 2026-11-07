resource "github_repository" "this" {
  name       = "${var.repo_name_prefix}-${var.repo_name}"
  auto_init  = true
  visibility = var.repo_visibility
}

resource "github_repository_file" "gitmodules" {
  repository          = github_repository.this.name
  branch              = "main"
  file                = ".gitmodules"
  content = join("\n", flatten([
    for leaf_name, leaf in module.leaves : [
      "[submodule \"${leaf.repository_name}\"]",
      "    path = ${leaf.repository_name}",
      "    url = ${leaf.repository_http_clone_url}",
      ""
    ]
  ]))
  commit_message      = "Generate .gitmodules"
  overwrite_on_create = true
}

resource "github_repository_custom_property" "cordon_topology" {
  repository    = github_repository.this.name
  property_name = "cordon_topology"
  property_type = "string"

  property_value = [
    jsonencode({
      varieties      = var.varieties
      aspect_options = var.aspect_options
      cordon         = var.cordon
    })
  ]
}

resource "github_branch" "source" {
  repository    = github_repository.this.name
  branch        = "development"
  source_branch = "main"

  depends_on = [
    github_repository_file.gitmodules,
  ]
}