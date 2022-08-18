resource "random_id" "random_id_prefix" {
  byte_length = 2
}

# Using custom Networking module
module "Networking" {
  source               = "./modules/Networking"
  region               = var.region
  environment          = var.environment
  vpc_cidr             = var.vpc_cidr
  public_subnets_cidr  = var.public_subnets_cidr
  private_subnets_cidr = var.private_subnets_cidr
}

# Using ec2-instance module from terraform registry
module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "ec2_private"

  ami                    = "ami-065deacbcaac64cf2"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [module.Networking.default_sg_id]
  subnet_id              = flatten(module.Networking.private_subnets_id)[0]
}

module "bastion" {
  source = "umotif-public/bastion/aws"
  version = "~> 2.1.0"

  name_prefix = "ec2_public"

  vpc_id         = module.Networking.vpc_id
  public_subnets = [flatten(module.Networking.public_subnets_id)[0]]

  ssh_key_name   = var.ec2_public_key

}