# ------------------------------------------------------------------------------
# GFN Security Group and rules
# ------------------------------------------------------------------------------
module "gfn_app_ec2_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 3.0"

  name        = "sgr-${var.application}-app-001"
  description = "Security group for the ${var.application} app ec2"
  vpc_id      = data.aws_vpc.vpc.id

  computed_ingress_with_source_security_group_id = [
    {
      rule                     = "http-8080-tcp"
      source_security_group_id = module.gfn_app_internal_alb_security_group.this_security_group_id
    }
  ]
  number_of_computed_ingress_with_source_security_group_id = 1

  egress_rules = ["all-all"]
}

resource "aws_security_group_rule" "jdbc" {

  security_group_id = module.gfn_app_internal_alb_security_group.this_security_group_id
  description       = "Allow on-premise jdbc queries"
  for_each          = toset(["1521"])
  type              = "ingress"
  from_port         = each.value
  to_port           = each.value
  protocol          = "tcp"
  cidr_blocks       = var.jdbc_client_ips
}

resource "aws_security_group_rule" "weblogic" {

  security_group_id = module.gfn_app_internal_alb_security_group.this_security_group_id
  description       = "Allow on-premise weblogic traffic"
  for_each          = toset(["58031","58032"])
  type              = "ingress"
  from_port         = each.value
  to_port           = each.value
  protocol          = "tcp"
  cidr_blocks       = var.weblogic_client_ips
}