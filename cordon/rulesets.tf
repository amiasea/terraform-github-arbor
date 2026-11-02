resource "github_repository_ruleset" "main" {
  name        = "main"
  repository  = github_repository.this.name
  target      = "branch"
  enforcement = "active"

  conditions {
    ref_name {
      include = [
        "refs/heads/main",
      ]
      exclude = []
    }
  }

  rules {
    update                  = false
    required_linear_history = true
    required_signatures     = false
    non_fast_forward        = true

    pull_request {
      required_approving_review_count = 1
      dismiss_stale_reviews_on_push   = true
      require_code_owner_review       = false
      require_last_push_approval      = false
    }
  }
}

resource "github_repository_ruleset" "development" {
  name        = "development"
  repository  = github_repository.this.name
  target      = "branch"
  enforcement = "active"

  conditions {
    ref_name {
      include = [
        "refs/heads/development",
      ]
      exclude = []
    }
  }

  rules {
    update                  = false
    required_linear_history = true
    required_signatures     = false
    non_fast_forward        = true

    pull_request {
      required_approving_review_count = 0
      dismiss_stale_reviews_on_push   = false
      require_code_owner_review       = false
      require_last_push_approval      = false
    }
  }
}

resource "github_repository_ruleset" "branch_creation" {
  name        = "Branch creation"
  repository  = github_repository.this.name
  target      = "branch"
  enforcement = "active"

  conditions {
    ref_name {
      include = ["~ALL"]
      exclude = []
    }
  }

  bypass_actors {
    actor_id    = var.github_app_id
    actor_type  = "Integration"
    bypass_mode = "always"
  }

  rules {
    creation = true
    deletion = true
  }
}