# create internet gateway and attach it to vpc
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id    = var.vpc_id 

  tags = {
    Name ="openvpn-igw"
  }
}