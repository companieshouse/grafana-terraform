# ------------------------------------------------------------------------------
# GFN Security Group and rules
# ------------------------------------------------------------------------------
module "gfn_app_ec2_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 3.0"

  name        = "sgr-${var.application}-app-001"
  description = "Security group for the ${var.application} app ec2"
  vpc_id      = data.aws_vpc.vpc.id

  ingress_with_self = [
    {
      rule = "http-80-tcp"
      self = true
    }
  ]

  #egress_rules = ["all-all"]
}

resource "aws_security_group_rule" "jdbc" {

  security_group_id = module.gfn_app_ec2_security_group.this_security_group_id
  description       = "Allow on-premise jdbc queries"
  type              = "ingress"
  from_port         = 1521
  to_port           = 1521
  protocol          = "tcp"
  cidr_blocks       = var.jdbc_client_ips
}

resource "aws_security_group_rule" "weblogic" {

  security_group_id = module.gfn_app_ec2_security_group.this_security_group_id
  description       = "Allow on-premise weblogic traffic"
  type              = "ingress"
  from_port         = 58031
  to_port           = 58032
  protocol          = "tcp"
  cidr_blocks       = var.weblogic_client_ips
}

resource "aws_security_group_rule" "clients" {

  security_group_id = module.gfn_app_ec2_security_group.this_security_group_id
  description       = "Allow on-prem client traffic"
  for_each          = toset(["22", "443"])
  type              = "ingress"
  from_port         = each.value
  to_port           = each.value
  protocol          = "tcp"
  cidr_blocks       = concat(local.admin_cidrs, var.logstash_client_ips)
}
