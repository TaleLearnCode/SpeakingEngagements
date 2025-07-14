# #############################################################################
# Presentation: In Defense of Microservices
# #############################################################################

locals {
  in_defense_of_microservices_label = {
    name        = "presentation:in-defense-of-microservices"
    description = "Tasks for In Defense of Microservices presentation"
  }
}

locals {
  in_defense_of_microservices_conferences = {
    devup2025        = local.conference_label_metadata.devup2025
  }
}

module "sin_defense_of_microservices" {
  source = "./modules/presentation_repo"

  private_repo_name        = "InDefenseOfMicroservices-private"
  public_repo_name         = "InDefenseOfMicroservices"
  description              = "Explore the enduring value of microservices by reiterating their benefits, countering common criticisms, and learning from real-world success stories to make informed architectural decisions."

  topics = [
    "microservices",
    "architecture",
    "real-world-examples",
    "software-architecture",
    "event-driven-architecture",
    "best-practices",
  ]

  task_labels = local.task_labels
  presentation_label = local.in_defense_of_microservices_label
  conference_labels  = local.in_defense_of_microservices_conferences

  task_label_color         = var.task_label_color
  presentation_label_color = var.presentation_label_color
  conference_label_color   = var.conference_label_color
}