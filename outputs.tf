output "variety_cordon_repositories" {
  value = {
    for cordon_name, cordon in module.cordon :
    cordon_name => {
      cordon = {
        name               = cordon_name
        repository_name    = cordon.repository_name
        repository_node_id = cordon.repository_id
      }

      varieties = {
        for variety_name in var.pomology.varieties :
        variety_name => {
          leaves = {
            for leaf_name, leaf in var.pomology.cordons[cordon_name].leaves :
            leaf_name => {
              repository_name    = cordon.leaves[leaf_name].repository_name
              repository_node_id = cordon.leaves[leaf_name].repository_node_id
              option             = leaf.options[variety_name]
            }
          }
        }
      }
    }
  }
}

output "organization" {
  value = {
    id = data.github_organization.this.id
    name = data.github_organization.this.name
  }
}