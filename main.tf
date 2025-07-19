module "vpc" {
  source    = "./modules/vpc"
  vpc_cidr  = "10.0.0.0/16"
}

module "ec2_backend" {
  source = "./modules/ec2_backend"

  ami_id              = data.aws_ami.amz-ami.id
  instance_type       = "t2.micro"
  key_name            = "sallam"
  private_key_path    = "/home/sallam/sallam.pem"

  private_subnet_1_id = module.subnets.private_subnet_1_id
  private_subnet_2_id = module.subnets.private_subnet_2_id
  security_group_id   = module.security_group.security_group_id

  bastion_host        = module.ec2_proxy.proxy1_public_ip
}


module "alb_internal" {
  source = "./modules/alb_internal"

  vpc_id              = module.vpc.vpc_id
  private_subnet_1_id = module.subnets.private_subnet_1_id
  private_subnet_2_id = module.subnets.private_subnet_2_id
  security_group_id   = module.security_group.security_group_id
  backend1_id         = module.ec2_backend.backend1_id
  backend2_id         = module.ec2_backend.backend2_id
}





module "subnets" {
  source = "./modules/subnets"
  vpc_id = module.vpc.vpc_id

  public_subnet_1_cidr = "10.0.0.0/24"
  public_subnet_1_az   = "us-east-1a"

  public_subnet_2_cidr = "10.0.1.0/24"
  public_subnet_2_az   = "us-east-1b"

  private_subnet_1_cidr = "10.0.2.0/24"
  private_subnet_1_az   = "us-east-1a"

  private_subnet_2_cidr = "10.0.3.0/24"
  private_subnet_2_az   = "us-east-1b"
}


module "nat_igw" {
  source           = "./modules/nat_igw"
  vpc_id           = module.vpc.vpc_id
  public_subnet_id = module.subnets.public_subnet_1_id
}

module "route_tables" {
  source              = "./modules/route_tables"
  vpc_id              = module.vpc.vpc_id

  internet_gateway_id = module.nat_igw.internet_gateway_id
  nat_gateway_id      = module.nat_igw.nat_gateway_id

  public_subnet_1_id  = module.subnets.public_subnet_1_id
  public_subnet_2_id  = module.subnets.public_subnet_2_id
  private_subnet_1_id = module.subnets.private_subnet_1_id
  private_subnet_2_id = module.subnets.private_subnet_2_id
}


module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
}


#----------------Data source ----------------------------------
data "aws_ami" "amz-ami" {
  most_recent = true
  owners      = ["amazon"]
   filter {
    name   = "name"
    values = ["al2023-ami-2023*"]
  }
   filter {
    name   = "architecture"
    values = ["x86_64"]
  }

}

module "ec2_proxy" {
  source              = "./modules/ec2_proxy"
  ami_id              = data.aws_ami.amz-ami.id
  instance_type       = "t2.micro"
  public_subnet_1_id  = module.subnets.public_subnet_1_id
  public_subnet_2_id  = module.subnets.public_subnet_2_id
  security_group_id   = module.security_group.security_group_id
  key_name            = "sallam"
  private_key_path    = "/home/sallam/sallam.pem"
  backend_alb_dns     = module.alb_internal.alb_dns_name
}



module "alb_public" {
  source              = "./modules/alb_public"
  vpc_id              = module.vpc.vpc_id
  public_subnet_1_id  = module.subnets.public_subnet_1_id
  public_subnet_2_id  = module.subnets.public_subnet_2_id
  security_group_id   = module.security_group.security_group_id
  proxy1_id           = module.ec2_proxy.proxy1_id
  proxy2_id           = module.ec2_proxy.proxy2_id

}




 #backend s3 bucket


 resource "aws_s3_bucket" "backend-s3" {
   bucket = "backend-tf-test-bucket-sallam"

 }


