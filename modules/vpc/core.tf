# Create the VPC for this env/stack
resource "aws_vpc" "vpc" {
  cidr_block = "10.${var.cidr_num}.0.0/16"
  tags       = "${merge(local.default_tags, map("Name", "vpc_${var.stack}"))}"
}

# Allow outbound internet access
resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags   = "${merge(local.default_tags, map("Name", "igw_${var.stack}"))}"
}

resource "aws_subnet" "nat_gw" {
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "10.${var.cidr_num}.1.0/24"
  availability_zone = "${data.aws_availability_zones.available.names[0]}"
  tags              = "${merge(local.default_tags, map("Name", "nat_gw_subnet_${var.stack}"))}"
}

resource "aws_eip" "nat_gw" {
  vpc = "true"
}

resource "aws_nat_gateway" "nat_gw" {
  allocation_id = "aws_eip.nat_gw.id"
  subnet_id     = "${aws_subnet.nat_gw.id}"
  tags          = "${merge(local.default_tags, map("Name", "nat_gw_eip_${var.stack}"))}"

  # You can explicitly depend on other resources if required.
  # Only do this if you're sure that you need to.
  depends_on    = ["aws_internet_gateway.igw"]
}

resource "aws_route_table" "main" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags   = "${merge(local.default_tags, map("Name", "rt_${var.stack}"))}"
}

resource "aws_route" "internet" {
  route_table_id         = "${aws_route_table.main.id}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${aws_nat_gateway.nat_gw.id}"
}
