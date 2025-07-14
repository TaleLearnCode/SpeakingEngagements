locals {
  presentation_labels = {
    "InDefenseOfMicroservices"          = local.in_defense_of_microservices_label
    #"NavigatingTheMaze"                 = local.navigating_the_maze_label
    #"ServerlessOrchestration"           = local.serverless_orchestration_label
    #"UnlockThePowerOfMessagingPatterns" = local.unlock_messaging_patterns_label
    #"GoingSchemaless"                   = local.going_schemaless_label
  }
}


resource "github_repository" "speaking_engagements" {
  name        = "SpeakingEngagements"
  description = "Repository for managing Chad Green's speaking engagements, including CFPs, presentations, and related tasks."

  visibility      = "public"
  has_issues      = true
  has_discussions = false
  has_projects    = true
  has_wiki        = false
  has_downloads   = false

  license_template = "mit"

  topics = [
    "speaking-engagements",
    "cfp",
    "presentations",
    "conferences"
  ]
}

resource "github_issue_label" "speaking_engagements_tasks" {
  for_each = {
    for label, description in local.task_labels : label => description
  }

  repository  = github_repository.speaking_engagements.name
  name        = each.key
  color       = var.task_label_color
  description = each.value
}

#resource "github_issue_label" "speaking_engagements_presentations" {
#  for_each = local.presentation_labels
#
#  repository  = github_repository.speaking_engagements.name
#  name        = each.value.name
#  color       = var.presentation_label_color
#  description = each.value.description
#}

resource "github_issue_label" "speaking_engagements_presentations" {
  for_each = local.presentation_labels

  repository  = github_repository.speaking_engagements.name
  name        = each.value.name
  color       = var.presentation_label_color
  description = each.value.description
}


resource "github_issue_label" "speaking_engagements_conferences" {
  for_each = local.conference_label_metadata

  repository  = github_repository.speaking_engagements.name
  name        = each.value.name
  color       = var.conference_label_color
  description = each.value.description
}