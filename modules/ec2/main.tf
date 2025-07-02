resource "aws_instance" "openvpn-ec2" {
  ami           = var.ami
  instance_type = "t3.medium"
  subnet_id     = var.public_subnet-1a
  vpc_security_group_ids = [var.security-group-id]


#   associate_public_ip_address = true
  key_name = "openvpn-testing"

  tags = {
        Name = "OpenVpn-${data.aws_region.current.name}"
    }

}