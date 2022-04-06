locals {

  internal_cidrs            = values(data.vault_generic_secret.internal_cidrs.data)
  application_subnet_cidrs  = [for s in data.aws_subnet.application : s.cidr_block]
  elb_access_logs_prefix    = "elb-access-logs"
  internal_fqdn             = format("%s.%s.aws.internal", split("-", var.aws_account)[1], split("-", var.aws_account)[0])

  #For each log map passed, add an extra kv for the log group name
  grafana_cw_logs    = { for log, map in var.grafana_cw_logs : log => merge(map, { "log_group_name" = "${var.application}-fe-${log}" }) }
  grafana_log_groups = compact([for log, map in local.grafana_cw_logs : lookup(map, "log_group_name", "")])


  kms_keys_data          = data.vault_generic_secret.kms_keys.data
  security_kms_keys_data = data.vault_generic_secret.security_kms_keys.data
  logs_kms_key_id        = local.kms_keys_data["logs"]
  ssm_kms_key_id         = local.security_kms_keys_data["session-manager-kms-key-arn"]
  
  security_s3_data            = data.vault_generic_secret.security_s3_buckets.data
  session_manager_bucket_name = local.security_s3_data["session-manager-bucket-name"]
  default_tags = {
    Terraform   = "true"
    Application = upper(var.application)
    Region      = var.aws_region
    Account     = var.aws_account
  }
}