locals {

  admin_cidrs               = values(data.vault_generic_secret.internal_cidrs.data)
  application_subnet_cidrs  = [for s in data.aws_subnet.application : s.cidr_block]
  elb_access_logs_prefix    = "elb-access-logs"
  internal_fqdn             = format("%s.%s.aws.internal", split("-", var.aws_account)[1], split("-", var.aws_account)[0])

  default_tags = {
    Terraform   = "true"
    Application = upper(var.application)
    Region      = var.aws_region
    Account     = var.aws_account
  }
}