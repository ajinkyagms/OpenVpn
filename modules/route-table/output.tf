output "prod_new-rtb-private" {
  value = aws_route_table.private-subnet-1a.id
}


output "prod_new-rtb-public" {
  value = aws_route_table.Public-subnet.id
}


