# ------------------------------------------------------------------------------
# GFN Security Group and rules
# ------------------------------------------------------------------------------
module "gfn_app_ec2_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 3.0"

  name                = "sgr-${var.application}-app-001"
  description         = "Security group for the ${var.application} app ec2"
  vpc_id              = data.aws_vpc.vpc.id
  ingress_cidr_blocks = local.internal_cidrs
  ingress_rules       = ["ssh-tcp"]


  egress_rules = ["all-all"]
}

resource "aws_security_group_rule" "clients" {

  security_group_id = module.gfn_app_ec2_security_group.this_security_group_id
  description       = "Allow client traffic"
  for_each          = toset(["3000","8083","8086","2003"])
  type              = "ingress"
  from_port         = each.value
  to_port           = each.value
  protocol          = "tcp"
  cidr_blocks       = concat(local.internal_cidrs, local.chs_cidrs, var.additional_client_cidrs)
}
