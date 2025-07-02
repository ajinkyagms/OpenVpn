provider "aws" {
    region = var.region_name
}

# ============= for the vpc ====================

module "vpc" {
    source = "./modules/vpc"
    vpc_cidr = var.vpc_cidr
    private_subnet_1a = var.private_subnet_1a
    private_subnet_1b = var.private_subnet_1b
    public_subnet_1a = var.public_subnet_1a 
    public_subnet_1b = var.public_subnet_1b
  
}

# ============= for the internet gateway -===============

module "internet-gateway"{
    source = "./modules/internet-gateway"
    vpc_id = module.vpc.vpc_id
    
}

# ============================  for the route table =======

module "route-table" {
    source = "./modules/route-table"
    vpc_id = module.vpc.vpc_id
    private_subnet-1a = module.vpc.private_subnet-1a
    private_subnet-1b =module.vpc.private_subnet-1b
    public_subnet-1a = module.vpc.public_subnet-1a 
    public_subnet-1b = module.vpc.public_subnet-1b
    internet_gateway = module.internet-gateway.internet_gateway
   
}

# ================ security group ======================= 


module "security-group" {
    source = "./modules/security-group"
    vpc_id = module.vpc.vpc_id
  
}




# ============== for the route table routes ==============

# module "route-table-routes" {
#     source = "./modules/stage/route-table-routes"
#     nat_gateway = module.nat-gateway.nat_gateway
#     prod_new-rtb-private = module.route-table.prod_new-rtb-private
#     prod_new-rtb-public = module.route-table.prod_new-rtb-public
#     internet_gateway = module.internet-gateway.internet_gateway
    
  
# }

# ============== for the ec2 ==============

module "ec2"{
    source = "./modules/ec2"
    public_subnet-1a =  module.vpc.public_subnet-1a
    security-group-id = module.security-group.security-group-id
    region_name = "Mumbai"
}

#Mumbai Region

# # Configure the AWS Provider
# provider "aws" {
#   region = "ap-south-1"
# }

# Create a VPC
resource "aws_vpc" "mumbai_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "mumbai-vpc"
  }
}

# Create a Subnet
resource "aws_subnet" "mumbai_subnet" {
  vpc_id     = aws_vpc.mumbai_vpc.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "mumbai-subnet"
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "mumbai_igw" {
  vpc_id = aws_vpc.mumbai_vpc.id
  tags = {
    Name = "mumbai-igw"
  }
}

# Create a Route Table
resource "aws_route_table" "mumbai_route_table" {
  vpc_id = aws_vpc.mumbai_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mumbai_igw.id
  }
  tags = {
    Name = "mumbai-route-table"
  }
}

# Associate the Route Table with the Subnet
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.mumbai_subnet.id
  route_table_id = aws_route_table.mumbai_route_table.id
}

# Create a Security Group
resource "aws_security_group" "instance_sg" {
  name        = "instance-sg"
  description = "Allow SSH and HTTP traffic"
  vpc_id      = aws_vpc.mumbai_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # WARNING: This is not secure for production
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "instance-sg"
  }
}

# Create the EC2 Instance
resource "aws_instance" "my_instance" {
  ami                    = "ami-02eb7a4783e2e9214" # Amazon Linux 2023 AMI for ap-south-1
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.mumbai_subnet.id
  vpc_security_group_ids = [aws_security_group.instance_sg.id]

  tags = {
    Name = "my-mumbai-instance"
  }
}
