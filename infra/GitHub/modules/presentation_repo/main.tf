terraform {
  required_providers {
    github = {
      source  = "integrations/github"
    }
  }
}

resource "github_repository" "private" {
  name        = var.private_repo_name
  description = var.description
  visibility  = "private"

  has_issues      = true
  has_discussions = false
  has_projects    = true
  has_wiki        = false
  has_downloads   = false

  license_template = var.private_repo_license
  topics           = var.topics

  template {
    owner                = var.template_owner
    repository           = var.private_template_repo
    include_all_branches = false
  }
}

resource "github_repository" "public" {
  name        = var.public_repo_name
  description = var.description
  visibility  = "public"

  has_issues     = true
  has_discussions = false
  has_projects   = true
  has_wiki       = false
  has_downloads  = false

  license_template = var.public_repo_license
  topics           = var.topics

  template {
    owner                = var.template_owner
    repository           = var.public_template_repo
    include_all_branches = false
  }
}

resource "github_issue_label" "task_labels" {
  for_each = {
    for label, description in var.task_labels : label => {
      name        = label
      description = description
    }
  }

  repository = github_repository.private.name
  name       = each.value.name
  color      = var.task_label_color
  description = each.value.description
}

resource "github_issue_label" "presentation_label" {
  repository  = github_repository.private.name
  name        = var.presentation_label.name
  color       = var.presentation_label_color
  description = var.presentation_label.description
}

resource "github_issue_label" "conference_labels" {
  for_each = var.conference_labels

  repository  = github_repository.private.name
  name        = each.value.name
  color       = var.conference_label_color
  description = each.value.description
}