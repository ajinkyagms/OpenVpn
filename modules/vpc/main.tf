resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  # Other VPC configuration options

  tags = {
    Name = "openvpn"  
  }
}


# create the private subnet for the  availability zone 

resource "aws_subnet" "private-subnet-1a" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_subnet_1a  # Pass the cidr_block for the dev_subnet
  availability_zone       = "us-east-1a"     # Example availability zone 
  map_public_ip_on_launch = false            # map_public_ip_on_launch is set to false, instances launched in this subnet will not be assigned a public IP address by default. This is commonly used for private subnets where you don't want instances to have direct internet access.

  tags = {
    Name ="openvpn-subnet-private1-us-east-1a"
  }
}


# create the private subnet for the us-east-1b availability zone 

resource "aws_subnet" "private-subnet-1b" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.private_subnet_1b  # Pass the cidr_block for the dev_subnet
  availability_zone       = "us-east-1b"     # Example availability zone 
  map_public_ip_on_launch = false            # map_public_ip_on_launch is set to false, instances launched in this subnet will not be assigned a public IP address by default. This is commonly used for private subnets where you don't want instances to have direct internet access.

  tags = {
    Name ="openvpn-subnet-private1-us-east-1b"
  }
}



# Attaching the public subnet into each availability zone

# Create a public subnet in us-east-1a

resource "aws_subnet" "public-subnet-1a" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_1a # Define the CIDR block for the public subnet in us-east-2a
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false # This allows instances launched in this subnet to receive public IP addresses.

  tags = {
    Name = "openvpn-subnet-public1-us-east-1a"
  }
}


# create the one public subnet for the application load balancer to solve the error 
resource "aws_subnet" "public-subnet-1b" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_1b # Define the CIDR block for the public subnet in us-east-2a
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false # This allows instances launched in this subnet to receive public IP addresses.

  tags = {
    Name = "openvpn-subnet-public2-us-east-1b"
  }
}


