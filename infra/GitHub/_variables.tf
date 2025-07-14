# #############################################################################
# Variables for GitHub Speaking Engagements Repos
# #############################################################################

# -----------------------------------------------------------------------------
# Label Colors
# -----------------------------------------------------------------------------

variable "task_label_color" {
  type    = string
  default = "B83280"
}

variable "conference_label_color" {
  type    = string
  default = "5A67D8"
}

variable "presentation_label_color" {
  type    = string
  default = "276749"
}

# -----------------------------------------------------------------------------
# Local Variables
# -----------------------------------------------------------------------------

locals {

  task_labels = {
    "task:cfp"           = "Call for Speakers tasks"
    "task:prep"          = "Preparation tasks for presentations"
    "task:sponsor-slide" = "Tasks related to sponsor slides for presentations"
    "task:promo-video"   = "Tasks related to promotional videos for presentations"
    "task:slide-review"  = "Tasks related to slide reviews for presentations"
    "task:slide-repo"    = "Tasks related to submitting slides to conference slide repository"
  }

  conference_label_metadata = {
    devup2025 = {
      name        = "conference:devup2025"
      description = "Tasks related to devup2025 (St. Charles, MO, USA; August 6-8)"
    }
    beercitycode2025 = {
      name        = "conference:beercitycode2025"
      description = "Tasks related to Beer City Code 2025 (Grand Rapids, MI, USA; August 8-9)"
    }
    kcdc2025 = {
      name        = "conference:kcdc2025"
      description = "Tasks related to KCDC 2025 (Kansas City, MO, USA; August 13-15)"
    }
  }

}