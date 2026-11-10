# Cost guardrail. Apply this BEFORE anything else in a new AWS account:
#   terraform apply -target=aws_budgets_budget.monthly
# (-target is normally an anti-pattern. Bootstrapping a guardrail is one of the few good uses.)
#
# Note: AWS Budgets *alerts*; it does not stop spending. `terraform destroy` at the end of every
# session is still your real cost control.
resource "aws_budgets_budget" "monthly" {
  name         = "${local.project}-${local.env}-monthly"
  budget_type  = "COST"
  limit_amount = tostring(var.budget_limit_usd)
  limit_unit   = "USD"
  time_unit    = "MONTHLY"

  dynamic "notification" {
    for_each = [50, 80, 100]
    content {
      comparison_operator        = "GREATER_THAN"
      threshold                  = notification.value
      threshold_type             = "PERCENTAGE"
      notification_type          = "ACTUAL"
      subscriber_email_addresses = [var.budget_alert_email]
    }
  }

  # Forecast alert: warns you early if a forgotten RDS instance will push you over the limit.
  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 100
    threshold_type             = "PERCENTAGE"
    notification_type          = "FORECASTED"
    subscriber_email_addresses = [var.budget_alert_email]
  }
}
