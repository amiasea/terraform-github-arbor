resource "github_branch" "source" {
  repository = var.repository_name
  branch     = var.source_branch
  source_sha = var.seed_sha
}

resource "github_branch" "derived" {
  repository    = var.repository_name
  branch        = var.derived_branch
  source_branch = var.source_branch

  depends_on = [
    github_branch.source
  ]
}