variable "name" {
  description = "Name of the AWS S3 Bucket"
  type        = string
  #required, no default

  validation {
    # must be 3-63 chars long, lowercase alphanumeric including periods and hyphens, begin and end with letter or number
    condition     = can(regex("^[a-z0-9][a-z0-9.-]*[a-z0-9]$", var.name))
    error_message = "Bucket name must contain only lowercase alphanumeric characters and may include periods or hyphens. The name must also start and end with an alphanumeric character"
  }

  validation {
    condition     = length(var.name) >= 3 && length(var.name) <= 63
    error_message = "Bucket name must be between 3 and 63 characters."
  }
}

variable "kms_key_arn" {
  description = "ARN of the KMS key used to encrypt the bucket data"
  type        = string
  #required, no default

  validation {
    condition     = can(regex("^arn:", var.kms_key_arn))
    error_message = "Must be a valid KMS key ARN starting with 'arn:'."
  }
}

variable "force_destroy" {
  description = "Inidcates all objects, including locked objects, should be deleted from the bucket when the bucket is destroyed."
  type        = bool
  default     = false

  # can be set to true for env/local and env/dev
}

variable "tags" {
  description = "Map of key/value tags to attach to the KMS key."
  type        = map(string)
  default     = {} # no extra tags by default
}

variable "noncurrent_version_expiration" {
  description = "Specifies the number of days an object is noncurrent before S3 can perform an associated action."
  type        = number
  default     = 30 #days

  validation {
    condition     = var.noncurrent_version_expiration > 0
    error_message = "Value must be a non-zero positive integer."
  }
}

variable "object_lock_enabled" {
  description = "When enabled, the bucket is created with the ability to use object locking. When false, the bucket is created without the abilty to use object locking."
  type        = bool
  default     = false
}
