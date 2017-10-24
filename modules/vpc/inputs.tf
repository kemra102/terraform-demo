variable "aws_region" {
  type = "string"
}

variable "cidr_num" {
  description = "The second octet of the CIDR range to be used by this VPC. For example setting to '2' would produce a CIDR range of '10.2.0.0/16'."
  type        = "string"
}

variable "stack" {
  description = "The environment or stack name."
}

variable "enable_internet_access" {
  description = "Boolean true/false if Internet access should be configured."
  default     = false
}

# Locals are a feature implemented to allow interpolation easily in places it wouldn't normally work.
# Like interpolation in variables.
# https://www.terraform.io/docs/configuration/locals.html
locals {
  # Default tags are good for code re-use. These can be added to with the merge function if required:
  # https://www.terraform.io/docs/configuration/interpolation.html#merge-map1-map2-
  default_tags = {
    module = "vpc"
    owner  = "infra-support"
    stack  = "${var.stack}"
  }
}

# Data sources aren't strictly speaking variables but are used in the same way
# so I like to keep them here.

# Get a list of the AZs in the current AWS region
data "aws_availability_zones" "available" {}
