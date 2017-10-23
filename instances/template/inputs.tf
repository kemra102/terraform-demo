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
