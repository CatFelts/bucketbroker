variable "aws_region" {
  description = "Your AWS project's selected Region. All resources must be created there. Find it in AWS Settings > View all projects > Overview > Additional Info > Region."
  type        = string
  # No default on purpose: deploying to the wrong Region fails under the project's service control policies.
}

variable "budget_limit_usd" {
  description = "Monthly cost budget in USD. Alerts fire at 50%, 80% and 100% (actual) and 100% (forecast)."
  type        = number
  default     = 10

  validation {
    condition     = var.budget_limit_usd > 0
    error_message = "budget_limit_usd must be positive."
  }
}

variable "budget_alert_email" {
  description = "Email address that receives budget alerts."
  type        = string

  validation {
    condition     = can(regex("^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$", var.budget_alert_email))
    error_message = "budget_alert_email must be a valid email address."
  }
}

variable "enable_rds" {
  description = "Create the RDS Postgres instance. Costs money while it exists, so destroy after each session."
  type        = bool
  default     = false
}

variable "enable_redis" {
  description = "Create the ElastiCache cluster. Costs money while it exists, so destroy after each session."
  type        = bool
  default     = false
}
