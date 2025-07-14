output "private_repository_name" {
  value       = github_repository.private.name
  description = "Name of the private GitHub repository created for the presentation"
}

output "public_repository_name" {
  value       = github_repository.public.name
  description = "Name of the public GitHub repository created for the presentation"
}

output "task_labels" {
  value       = [for label in keys(var.task_labels) : label]
  description = "List of task label names applied to the private repository"
}

output "presentation_label" {
  value       = var.presentation_label.name
  description = "Presentation-specific label name applied to the private repository"
}

output "conference_labels" {
  value       = [for k, v in var.conference_labels : v.name]
  description = "Conference label names applied to the private repository"
}
