output "repository_name" {
  value = github_repository.this.name
}

output "repository_id" {
  value = github_repository.this.name
}

output "repository_node_id" {
  value = github_repository.this.node_id
}

output "leaves" {
  value = {
    for leaf_name, leaf in module.leaves :
    leaf_name => {
      repository_name     = leaf.repository_name
      repository_id       = leaf.repository_id
      repository_node_id  = leaf.repository_node_id
    }
  }
}