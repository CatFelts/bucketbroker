# Suggested inputs. Give each one a `type`, a `description`, and a `validation {}` block where it helps:
#
#   name                    string        required. Used to build the alias. Validate with a regex:
#                                         lowercase letters, digits and hyphens only.
#   description             string        optional, with a sensible default
#   deletion_window_in_days number        default 7. Validate the range 7–30 (the KMS limits).
#   tags                    map(string)   default {}
#
# Example of the convention, so the shape is clear (uncomment and adapt):
#
# variable "tags" {
#   description = "Tags applied to every resource in this module."
#   type        = map(string)
#   default     = {}
# }
