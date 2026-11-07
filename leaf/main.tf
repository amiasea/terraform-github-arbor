resource "github_repository" "this" {
  name       = "${var.repo_name_prefix}-${var.repo_name}"
  auto_init  = true
  visibility = var.repo_visibility
}

resource "github_repository_file" "merge_gate" {
  repository = github_repository.this.name

  file                = ".github/workflows/merge_gate.yml"
  content             = file("${path.module}/merge_gate.yml")
  branch              = "main"
  commit_message      = "Manage merge gate workflow"
  overwrite_on_create = true
}

resource "github_branch" "source" {
  repository    = github_repository.this.name
  branch        = "development"
  source_branch = "main"

  depends_on = [
    github_repository.this,
    github_repository_file.merge_gate
  ]
}