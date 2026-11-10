module "cordon" {
  source   = "./cordon"
  for_each = var.pomology.cordons

  repo_visibility  = var.repo_visibility
  repo_name_prefix = var.repo_name_prefix
  repo_name        = each.key
  github_app_id    = var.github_app_id

  varieties      = var.pomology.varieties
  aspect_options = var.pomology.aspectOptions
  cordon         = each.value
  child_cordon_names = [
    for cordon_name, cordon in var.pomology.cordons :
    cordon_name
    if cordon.tier == each.key
  ]

  pomology_definitions_release_tag = var.pomology_definitions_release_tag
}

data "github_organization" "this" {
  name = var.github_organization_name
}
