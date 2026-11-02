module "leaves" {
  source   = "../leaf"
  for_each = var.leaves

  repo_name_prefix = "${var.repo_name_prefix}-${var.repo_name}"
  repo_name        = each.key
  aspect_options   = sort(distinct(values(each.value.options)))
  repo_visibility  = var.repo_visibility
  github_app_id    = var.github_app_id
}