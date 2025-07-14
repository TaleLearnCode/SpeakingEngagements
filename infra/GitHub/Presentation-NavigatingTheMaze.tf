# #############################################################################
# Presentation: Navigating the Maze
# #############################################################################

locals {
  navigating_the_maze_label = {
    name        = "presentation:navigating-the-maze"
    description = "Tasks for Navigating the Maze presentation"
  }
}

locals {
  navigating_the_maze_conferences = {
    devup2025        = local.conference_label_metadata.devup2025
  }
}

module "navigating_the_maze" {
  source = "./modules/presentation_repo"

  private_repo_name        = "NavigatingTheMaze-private"
  public_repo_name         = "NavigatingTheMaze"
  description              = "This session explores the pivotal role of Architecture Decision Records (ADRs) in enhancing communication within architectural teams, showcasing their effectiveness in documenting decisions, and providing insights into best practices for leveraging ADRs to maintain architectural integrity."

  topics = [
    "architecture-decision-records",
    "adr",
    "communication",
    "software-architecture",
    "best-practices",
    "documentation",
    "team-collaboration",
    "software-development"
  ]

  task_labels = local.task_labels
  presentation_label = local.navigating_the_maze_label
  conference_labels  = local.navigating_the_maze_conferences

  task_label_color         = var.task_label_color
  presentation_label_color = var.presentation_label_color
  conference_label_color   = var.conference_label_color
}