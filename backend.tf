terraform {
  backend "s3" {
    bucket         = "openvpn-bucker"
    key            = "terraform.tfstate"
    region         = "us-east-1" #***
    encrypt        = true
   
  }
}