output "repository_name" {
  description = "Name of the leaf repository."
  value       = github_repository.this.name
}

output "repository_id" {
  description = "Immutable GitHub ID of the leaf repository."
  value       = github_repository.this.repo_id
}

output "repository_node_id" {
  description = "Immutable GitHub node ID of the leaf repository."
  value       = github_repository.this.node_id
}

output "repository_http_clone_url" {
  description = "HTTP clone URL of the leaf repository."
  value       = github_repository.this.http_clone_url
}