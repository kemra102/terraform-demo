output "vpc_cidr_block" {
  value = "${aws_vpc.vpc.cidr_block}"
}

output "nat_gw_subnet_cidr_block" {
  value = "${aws_subnet.nat_gw.cidr_block}"
}

output "nat_gw_public_ip" {
  value = "${aws_eip.nat_gw.public_ip}"
}
