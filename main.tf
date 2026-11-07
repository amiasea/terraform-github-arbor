module "cordon" {
  source   = "./cordon"
  for_each = var.pomology.cordons

  repo_visibility  = var.repo_visibility
  repo_name_prefix = var.repo_name_prefix
  repo_name        = each.key
  github_app_id    = var.github_app_id

  varieties = var.pomology.varieties
  aspect_options = var.pomology.aspectOptions
  cordon = each.value
}

data "github_organization" "this" {
  name = var.github_organization_name
}
