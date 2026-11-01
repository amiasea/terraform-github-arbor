provider "github" {
  owner = "amiasea-development"

  // GITHUB_TOKEN PAT is expected for tetss
  # app_auth {}
}

run "pomology" {
  command = plan

  variables {
    github_organization_name = "amiasea-development"

    github_app_id = "5476448"

    repo_name_prefix = "test"

    pomology = jsondecode(file("tests/pomology.json"))
  }

  assert {
    condition = (
      length(output.variety_cordon_repositories) == length(var.pomology.cordons) &&
      alltrue([
        for cordon_name, result in output.variety_cordon_repositories :
        result.cordon.name == cordon_name &&
        result.cordon.repository_name != "" &&
        result.cordon.repository_node_id != "" &&
        length(result.varieties) == length(var.pomology.varieties) &&
        alltrue([
          for variety_name in var.pomology.varieties :
          contains(keys(result.varieties), variety_name) &&
          alltrue([
            for leaf_name, leaf in result.varieties[variety_name].leaves :
            leaf.repository_name != "" &&
            leaf.repository_node_id != "" &&
            leaf.option == var.pomology.cordons[cordon_name].leaves[leaf_name].options[variety_name]
          ])
        ])
      ])
    )

    error_message = "Each Cordon must expose its repository name and node ID, every declared variety, and each leaf's repository name, node ID, and correct selected option."
  }
}