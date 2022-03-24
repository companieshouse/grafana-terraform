# Account details
aws_profile = "heritage-development-eu-west-2"
aws_region  = "eu-west-2"
aws_account = "heritage-live"

# Account shorthand
account = "hlive"
region  = "euw2"

# Application details
application = "gfn"
environment = "live"

jdbc_client_ips = [
  "172.24.9.50/32",
  "172.24.9.52/32",
  "172.24.9.53/32",
  "10.84.8.125/32",
  "172.24.9.50/32",
  "172.24.9.52/32",
  "172.24.9.53/32"
]

weblogic_client_ips = [
  "172.24.4.66/32",
  "172.24.4.71/32"
]

####  Commented out until ready to include  ####
#
## Frontend ASG settings
#gfn_app_instance_size = "t3.medium"
#gfn_app_min_size = 1
#gfn_app_max_size = 1
#gfn_app_desired_capacity = 1
#gfn_app_scaling_schedule_stop = "00 20 * * 1-5"
#gfn_app_scaling_schedule_start = "00 06 * * 1-5"
#
#gfn_app_cw_logs = {
#  "audit.log" = {
#    file_path = "/var/log/audit"
#    log_group_retention = 7
#  }
#  
#  "messages" = {
#    file_path = "/var/log"
#    log_group_retention = 7
#  }
#  
#  "secure" = {
#    file_path = "/var/log"
#    log_group_retention = 7
#  }
#
#  "yum.log" = {
#    file_path = "/var/log"
#    log_group_retention = 7
#  }
#
#  "errors.log" = {
#    file_path = "/var/log/amazon/ssm"
#    log_group_retention = 7
#  }
#
#  "amazon-ssm-agent.log" = {
#    file_path = "/var/log/amazon/ssm"
#    log_group_retention = 7
#  }
#}