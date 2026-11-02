# Espalier Terraform Module

The Espalier Terraform module provisions a GitHub repository hierarchy from a Pomology definition. It creates the repositories and Git branch structures needed to represent a Solution's selected Varieties and their constituent Leaves.

Espalier uses ordinary Git and GitHub structures to represent repository composition. Terraform provisions those structures; it does not replace the Git model or determine whether a repository hierarchy is valid.

## Concepts

| Term | Meaning |
|---|---|
| **Pomology** | A definition of a Solution's repository hierarchy, available Varieties, and aspect options. |
| **Arboretum** | The curated set of permitted alternatives for a Solution. |
| **Variety** | A selectable configuration of a Solution. |
| **Cordon** | A repository that forms a structural node in the repository hierarchy. |
| **Leaf** | A repository included directly in a Cordon's composition for a given Variety. |
| **Aspect option** | The option selected for a Leaf within a particular Variety. |

## Requirements

- Terraform meeting the version constraint declared by the module.
- The `integrations/github` Terraform provider meeting the version constraint declared by the module.
- GitHub authentication with permission to create and configure the repositories managed by the module.
- A valid Pomology definition supplied by the calling configuration.

The GitHub provider must be configured by the root configuration or calling Terraform Stack.

## Usage

Reference the module from the Terraform Registry:

```hcl
module "espalier" {
  source  = "amiasea/espalier/github"
  version = "x.y.z"

  pomology = jsondecode(
    file("${path.module}/pomology.json")
  )
}
```

Replace `x.y.z` with the module version you intend to use. The example assumes that `pomology.json` contains a Pomology definition compatible with the module's input schema.

For a local checkout, use a local module source instead:

```hcl
module "espalier" {
  source = "../terraform-github-espalier"

  pomology = jsondecode(
    file("${path.module}/pomology.json")
  )
}
```

## Inputs

The primary input is `pomology`, which defines the repository structure and available selections.

The module's complete input contract is defined by its `variables.tf` file. Optional inputs, defaults, naming conventions, and validation rules should be taken from that contract.

## Outputs

### `organization`

Returns metadata for the GitHub organization containing the managed repositories, including its ID and name.

### `variety_cordon_repositories`

Returns repository metadata organized by Cordon and Variety. For each Cordon, the output describes the Cordon repository and its Leaves. Each Variety's Leaf entries include the repository metadata and the aspect option selected for that Leaf.

The output is intended for downstream Terraform configurations that need to reason about the repositories belonging to a particular Solution and its Varieties.

Repository IDs and GraphQL node IDs are distinct identifiers. Consumers should use the numeric repository ID when an API or trust policy requires it, and the GraphQL node ID when an API specifically requires that identifier.

## Design boundaries

- **Definitions are inputs.** The Pomology definition describes the intended repository structure; the module provisions the corresponding GitHub resources.
- **Repository composition uses Git structures.** Repository relationships are represented through GitHub repositories and Git metadata, rather than a separate runtime hierarchy service.
- **Provisioning and validation are distinct.** Creating the repository structure does not, by itself, prove that the resulting Git state satisfies every Espalier convention.
- **Downstream consumers own their policies.** This module exposes repository metadata and selection information. Consumers can use those outputs to configure access policies and other solution-specific infrastructure.

## License

See [LICENSE](LICENSE) for the terms governing use and distribution.
