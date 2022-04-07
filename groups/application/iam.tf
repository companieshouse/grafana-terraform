module "gfn_app_profile" {
  source = "git@github.com:companieshouse/terraform-modules//aws/instance_profile?ref=tags/1.0.59"

  name       = "gfn-frontend-profile"
  enable_SSM = true
  cw_log_group_arns = length(local.grafana_log_groups) > 0 ? flatten([
    formatlist(
      "arn:aws:logs:%s:%s:log-group:%s:*:*",
      var.aws_region,
      data.aws_caller_identity.current.account_id,
      local.grafana_log_groups
    ),
    formatlist("arn:aws:logs:%s:%s:log-group:%s:*",
      var.aws_region,
      data.aws_caller_identity.current.account_id,
      local.grafana_log_groups
    ),
  ]) : null
  kms_key_refs = [
    "alias/${var.account}/${var.region}/ebs",
    local.ssm_kms_key_id
  ]
  s3_buckets_write = [local.session_manager_bucket_name]

  custom_statements = [
    {
      sid       = "AllowWriteToRoute53",
      effect    = "Allow",
      resources = ["arn:aws:route53:::hostedzone/${data.aws_route53_zone.private_zone.zone_id}"],
      actions = [
        "route53:ChangeResourceRecordSets"
      ]
    }
  ]
}
