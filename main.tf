module "networking" {
  source               = "./networking"
  vpc_cidr_block       = var.vpc_cidr_block
  cidr_private_subnets = var.cidr_private_subnets
  cidr_public_subnets  = var.cidr_public_subnets
  availability_zone    = var.availability_zone
}
module "sg" {
  source              = "./sg"
  vpc_id              = module.networking.vpc_id
  public_subnets_cidr = tolist(module.networking.public_subnets_cidr)
}
module "ec2" {
  source         = "./ec2"
  subnet_id      = tolist(module.networking.public_subnets_id)[0]
  sg_22_80       = module.sg.sg_22_80
  sg_5000        = module.sg.sg_5000
  install_apache = templatefile("./ec2/install_apache.sh", {})
  public_key     = var.public_key
}
module "tg" {
  source = "./targetgroup"
  vpc_id = module.networking.vpc_id
  ec2_id = module.ec2.ec2_id
}
module "lb" {
  source         = "./lb"
  sg_lb          = module.sg.sg_22_80
  public_subnets = tolist(module.networking.public_subnets_id)
  target_group   = module.tg.target_id
  ec2_id         = module.ec2.ec2_id
}
module "hz" {
  source          = "./hosted_zone"
  aws_lb_dns_name = module.lb.name_lb
  aws_lb_zone_id  = module.lb.zone_lb
}


module "db" {
  source          = "./rds"
  subnet_group_db = tolist(module.networking.public_subnets_id)
  sg_db           = module.sg.sg_3306
}
