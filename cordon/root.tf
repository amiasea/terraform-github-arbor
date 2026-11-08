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

resource "github_repository_file" "pull_request" {
  repository          = github_repository.this.name
  branch              = "main"
  file                = ".github/workflows/pull_request.yml"
  content             = templatefile("${path.module}/pull_request.yml.tmpl", {
    solution_definitions_release_tag = var.solution_definitions_release_tag
  })
  commit_message      = "Add composition validation workflow"
  overwrite_on_create = true

  depends_on = [
    github_repository_file.gitmodules
  ]
}

resource "github_repository_custom_property" "cordon" {
  repository    = github_repository.this.name
  property_name = "cordon"
  property_type = "true_false"

  property_value = ["true"]
}

resource "github_repository_custom_property" "varieties" {
  repository    = github_repository.this.name
  property_name = "varieties"
  property_type = "string"

  property_value = [join(",", var.varieties)]
}

resource "github_repository_custom_property" "aspect_options" {
  repository    = github_repository.this.name
  property_name = "aspect_options"
  property_type = "string"

  property_value = [join(",", var.aspect_options)]
}

resource "github_repository_custom_property" "tier" {
  count = var.cordon.tier == null ? 0 : 1

  repository    = github_repository.this.name
  property_name = "tier"
  property_type = "string"
  property_value = [var.cordon.tier]
}

resource "github_branch" "source" {
  repository    = github_repository.this.name
  branch        = "development"
  source_branch = "main"

  depends_on = [
    github_repository_file.gitmodules,
  ]
}