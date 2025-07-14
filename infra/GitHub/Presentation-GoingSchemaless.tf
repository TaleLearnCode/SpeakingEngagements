# #############################################################################
# Presentation: Going Schemaless
# #############################################################################

locals {
  going_schemaless_label = {
    name        = "presentation:going-schemaless"
    description = "Tasks for Going Schemaless presentation"
  }
}

locals {
  going_schemaless_conferences = {
    devup2025        = local.conference_label_metadata.beercitycode2025
  }
}

module "going_schemaless" {
  source = "./modules/presentation_repo"

  private_repo_name        = "GoingSchemaless-private"
  public_repo_name         = "GoingSchemaless"
  description              = "This session explores the benefits and challenges of adopting a schemaless approach in modern application development, focusing on practical strategies for implementing flexible data models."

  topics = [
    "database",
    "nosql",
    "azure",
    "cosmos-db",
    "cosmosdb",
    "schemaless",
    "data-modeling",
    "flexible-data",
    "application-development",
    "best-practices"
  ]

  task_labels = local.task_labels
  presentation_label = local.going_schemaless_label
  conference_labels  = local.going_schemaless_conferences

  task_label_color         = var.task_label_color
  presentation_label_color = var.presentation_label_color
  conference_label_color   = var.conference_label_color
}