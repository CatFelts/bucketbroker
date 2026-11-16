variable "deletion_window_in_days" {
  description = "Number between 7 and 30, the duration a kms key is in pending state before deletion."
  type        = number
  default     = 30 #setting to the max duration if a user forgets

  validation {
    # enforce number range 7<=n<=30
    condition     = var.deletion_window_in_days >= 7 && var.deletion_window_in_days <= 30
    error_message = "The deletion window must be between 7 and 30 days."
  }
}

variable "name" {
  description = "Lowercase alphanumeric string which can include hyphens, used to generate the key alias 'alias/{name}'."
  type        = string
  # no default, required

  validation {
    # a 'alias/' prefix will be added to the user specified name, must be lower case alphanumeric including hyphens only
    condition     = can(regex("^[a-z0-9-]+$", var.name)) && length(var.name) <= 250
    error_message = "The key name can only include lowercase alphanumeric characters and hyphens, and can be no longer than 250 characters."
  }
}

variable "description" {
  description = "Description of what the given KMS key protects."
  type        = string
  default     = ""

  validation {
    # optional, and limited to 8192 chars
    condition     = length(var.description) <= 8192
    error_message = "The key description can either be empty or must not be longer than 8192 characters."
  }
}

variable "tags" {
  description = "Map of key/value tags to attach to the KMS key."
  type        = map(string)
  default     = {} # no extra tags by default
}
