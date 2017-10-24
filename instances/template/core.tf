module "vpc" {
  source = "../../modules/vpc"

  aws_region             = "${var.aws_region}"
  cidr_num               = "${var.cidr_num}"
  stack                  = "${var.stack}"
  enable_internet_access = "${var.enable_internet_access}"
}
