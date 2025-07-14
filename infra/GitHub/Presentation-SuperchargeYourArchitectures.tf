# #############################################################################
# Presentation: Supercharge Your Architectures with Messaging Patterns
# #############################################################################

locals {
  supercharge_your_architecture_label = {
    name        = "presentation:supercharge-your-architectures"
    description = "Tasks for Supercharge Your Architectures with Messaging Patterns presentation"
  }
}

locals {
  supercharge_your_architecture_conferences = {
    devup2025        = local.conference_label_metadata.devup2025
    beercitycode2025 = local.conference_label_metadata.beercitycode2025
  }
}

module "supercharge_your_architecture" {
  source = "./modules/presentation_repo"

  private_repo_name        = "UnlockThePowerOfMessagingPatterns-private"
  public_repo_name         = "SuperchargeYourArchitecturesWithMessagingPatterns"
  description              = "This hands-on workshop equips developers and architects with practical skills to implement robust messaging patterns like Publish-Subscribe, Message Queues, and Request-Reply, applicable across AWS, Azure, and Google Cloud. Build resilient, scalable cloud applications through interactive labs and real-world examples."

  topics = [
    "messaging-patterns",
    "cloud-architecture",
    "hands-on-workshop"
  ]

  task_labels = local.task_labels
  presentation_label = local.supercharge_your_architecture_label
  conference_labels  = local.supercharge_your_architecture_conferences

  task_label_color         = var.task_label_color
  presentation_label_color = var.presentation_label_color
  conference_label_color   = var.conference_label_color
}