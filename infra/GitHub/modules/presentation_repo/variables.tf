variable "private_repo_name" {
  description = "The name of the private GitHub repository for the presentation"
  type        = string
}

variable "public_repo_name" {
  description = "The name of the public GitHub repository for the presentation"
  type        = string
}

variable "private_repo_license" {
  description = "The license for the private repository"
  type        = string
  default     = "mit"
}

variable "public_repo_license" {
  description = "The license for the public repository"
  type        = string
  default     = "mit"
}

variable "description" {
  description = "The shared description for both private and public repositories"
  type        = string
}

variable "topics" {
  description = "A list of GitHub repository topics used for tagging both repositories"
  type        = list(string)
}

variable "template_owner" {
  description = "The GitHub username or organization that owns the template repositories"
  type        = string
  default     = "TaleLearnCode"
}

variable "private_template_repo" {
  description = "The name of the private template repository to clone from"
  type        = string
  default     = "PresentationTemplate"
}

variable "public_template_repo" {
  description = "The name of the public template repository to clone from"
  type        = string
  default     = "PublicPresentationTemplate"
}

variable "task_label_color" {
  description = "Hex color code for task-related issue labels"
  type        = string
}

variable "presentation_label_color" {
  description = "Hex color code for presentation-specific issue labels"
  type        = string
}

variable "conference_label_color" {
  description = "Hex color code for conference-related issue labels"
  type        = string
}

variable "task_labels" {
  description = "Map of task label names to descriptions for the presentation repo"
  type        = map(string)
}

variable "presentation_label" {
  description = "Presentation-specific label object containing name and description"
  type = object({
    name        = string
    description = string
  })
}

variable "conference_labels" {
  description = "Map of conference label identifiers to name/description objects"
  type = map(object({
    name        = string
    description = string
  }))
}