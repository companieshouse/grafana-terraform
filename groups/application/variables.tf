
# ------------------------------------------------------------------------------
# AWS Variables
# ------------------------------------------------------------------------------
variable "aws_region" {
  type        = string
  description = "The AWS region in which resources will be administered"
}

variable "aws_profile" {
  type        = string
  description = "The AWS profile to use"
}

variable "aws_account" {
  type        = string
  description = "The name of the AWS Account in which resources will be administered"
}

# ------------------------------------------------------------------------------
# AWS Variables - Shorthand
# ------------------------------------------------------------------------------

variable "account" {
  type        = string
  description = "Short version of the name of the AWS Account in which resources will be administered"
}

variable "region" {
  type        = string
  description = "Short version of the name of the AWS region in which resources will be administered"
}

# ------------------------------------------------------------------------------
# Environment Variables
# ------------------------------------------------------------------------------

variable "application" {
  type        = string
  description = "The name of the application"
}

variable "environment" {
  type        = string
  description = "The name of the environment"
}

variable "domain_name" {
  type        = string
  default     = "*.companieshouse.gov.uk"
  description = "Domain Name for ACM Certificate"
}


variable "jdbc_client_ips" {
  type        = list(any)
  description = "The IPs required for JDBC queries"
}

variable "weblogic_client_ips" {
  type        = list(any)
  description = "The IPs required for weblogic queries"
}

variable "logstash_client_ips" {
  type        = list(any)
  description = "The IPs required for weblogic queries"
}

variable "vault_username" {
  type        = string
  description = "Username for connecting to Vault"
}

variable "vault_password" {
  type        = string
  description = "Password for connecting to Vault"
}
/*

      # ------------------------------------------------------------------------------
      # GFN Frontend Variables - ALB 
      # ------------------------------------------------------------------------------

      variable "gfn_app_service_port" {
        type        = number
        default     = 8080
        description = "Target group backend port"
      }

      variable "gfn_app_health_check_path" {
        type        = string
        default     = "/"
        description = "Target group health check path"
      }

      variable "gfn_app_min_size" {
        type        = number
        description = "The min size of the ASG"
      }

      variable "gfn_app_max_size" {
        type        = number
        description = "The max size of the ASG"
      }

      variable "gfn_app_desired_capacity" {
        type        = number
        description = "The desired capacity of ASG"
      }

      variable "gfn_app_scaling_schedule_stop" {
        type        = string
        description = "The schedule for scaling  the ASG"
      }

      variable "gfn_app_scaling_schedule_start" {
        type        = string
        description = "The schedule for scaling the ASG"
      }
*/
