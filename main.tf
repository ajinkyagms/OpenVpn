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
}
