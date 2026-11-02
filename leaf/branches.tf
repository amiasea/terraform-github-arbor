module "aspect_option_branch_pairs" {
  source   = "../branch_pair"
  for_each = toset(var.aspect_options)

  repository_name = github_repository.this.name
  source_branch   = "${each.value}-main"
  derived_branch  = "${each.value}-development"
  seed_sha        = github_branch.source.sha
}
