# #############################################################################
# Presentation: Transform Chaos into Order with Azure Durable Functions
# #############################################################################

locals {
  transform_chaos_into_order_label = {
    name        = "presentation:transform-chaos-into-order"
    description = "Tasks for Transform Chaos into Order with Azure Durable Functions presentation"
  }
}

locals {
  transform_chaos_into_order_conferences = {
    devup2025        = local.conference_label_metadata.beercitycode2025
  }
}

module "transform_chaos_into_order" {
  source = "./modules/presentation_repo"

  private_repo_name        = "ServerlessOrchestration-private"
  public_repo_name         = "TransformChaosIntoOrderWithAzureDurableFunctions"
  description              = "Explore the capabilities of Azure Durable Functions in orchestrating serverless .NET workflows, covering essential patterns and best practices for seamless application orchestration in the cloud."

  topics = [
    "serverless",
    "azure-durable-functions",
    "orchestration",
    "cloud-computing",
    "durable-functions",
    "workflows",
    "best-practices"
  ]


  task_labels = local.task_labels
  presentation_label = local.transform_chaos_into_order_label
  conference_labels  = local.transform_chaos_into_order_conferences

  task_label_color         = var.task_label_color
  presentation_label_color = var.presentation_label_color
  conference_label_color   = var.conference_label_color
}