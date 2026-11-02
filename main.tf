module "cordon" {
  source   = "./cordon"
  for_each = var.pomology.cordons

  repo_visibility  = var.repo_visibility
  repo_name_prefix = var.repo_name_prefix
  repo_name        = each.key
  leaves           = each.value.leaves
  github_app_id    = var.github_app_id
}

data "github_organization" "this" {
  name = var.github_organization_name
}
