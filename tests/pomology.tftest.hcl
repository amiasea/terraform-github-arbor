provider "github" {
  owner = "amiasea-enterprise-orchard"

  legacy_client = false

  app_auth {}
}

run "pomology" {
  command = apply

  variables {
    github_organization_name = "amiasea-enterprise-orchard"

    github_app_id = "2670685"

    repo_name_prefix = "test"

    pomology = jsondecode(file("tests/pomology.json"))

    pomology_flora_release_tag = "v1.0.0-testing"
  }

  assert {
    condition = (
      length(output.variety_cordon_repositories) == length(var.pomology.cordons) &&
      alltrue([
        for cordon_name, result in output.variety_cordon_repositories :
        result.cordon.name == cordon_name &&
        result.cordon.repository_name != "" &&
        result.cordon.repository_id != "" &&
        result.cordon.repository_node_id != "" &&
        length(result.varieties) == length(var.pomology.varieties) &&
        alltrue([
          for variety_name in var.pomology.varieties :
          contains(keys(result.varieties), variety_name) &&
          alltrue([
            for leaf_name, leaf in result.varieties[variety_name].leaves :
            leaf.repository_name != "" &&
            leaf.repository_id != "" &&
            leaf.repository_node_id != "" &&
            leaf.path == leaf.repository_name &&
            leaf.url != "" &&
            leaf.option == var.pomology.cordons[cordon_name].leaves[leaf_name].options[variety_name]
          ])
        ])
      ])
    )

    error_message = "Each Cordon must expose its repository identity and every declared variety; each Leaf must expose its repository identity, path, HTTP clone URL, and correct selected option."
  }
}