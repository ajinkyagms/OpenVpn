output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "private_subnet-1a" {
  value = aws_subnet.private-subnet-1a.id
}

output "private_subnet-1b" {
  value = aws_subnet.private-subnet-1b.id
}

output "public_subnet-1a" {
  value = aws_subnet.public-subnet-1a.id
}

output "public_subnet-1b" {
  value = aws_subnet.public-subnet-1b.id
}
