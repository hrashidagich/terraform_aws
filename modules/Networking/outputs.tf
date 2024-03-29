output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnets_id" {
  value = ["${aws_subnet.public_subnet.*.id}"]
}

output "private_subnets_id" {
  value = ["${aws_subnet.private_subnet.*.id}"]
}

output "default_sg_id" {
  value = aws_security_group.default.id
}

output "bastion_sg_id" {
  value = aws_security_group.bastion.id
}

output "public_route_table" {
  value = aws_route_table.public.id
}