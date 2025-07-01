# create the route table for the private-subnet 

resource "aws_route_table" "private-subnet-1a" {
  vpc_id = var.vpc_id
  
  tags = {
    Name = "openvpn-rtb-private"
  }
}

# Associate private-subnet-1b with the common route table
resource "aws_route_table_association" "private-subnet-association-1a" {
  subnet_id      = var.private_subnet-1a
  route_table_id = aws_route_table.private-subnet-1a.id
}


# resource "aws_route" "private_nat_gateway-1b" {
#   route_table_id         = aws_route_table.private-subnet-1a.id
#   destination_cidr_block = "0.0.0.0/0"
#   nat_gateway_id         =  var.nat_gateway_public_subnet_1a # Replace with your NAT Gateway ID
# }


# Associate private-subnet-1b with the common route table
resource "aws_route_table_association" "private-subnet-association-1b" {
  subnet_id      = var.private_subnet-1b 
  route_table_id = aws_route_table.private-subnet-1a.id
}


# create the route table for the public subnet 


resource "aws_route_table" "Public-subnet" {
  vpc_id = var.vpc_id
  
  tags = {
    Name = "openvpn-rtb-public"
  }
}


# Create a default route for public subnets to reach the Internet via the Internet Gateway
resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.Public-subnet.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.internet_gateway  # Replace with your Internet Gateway ID
}

resource "aws_route_table_association" "public-subnet-association-1a" {
  subnet_id      = var.public_subnet-1a 
  route_table_id = aws_route_table.Public-subnet.id
  
}


resource "aws_route_table_association" "public-subnet-association-1b" {
  subnet_id      = var.public_subnet-1b
  route_table_id = aws_route_table.Public-subnet.id
  
}


