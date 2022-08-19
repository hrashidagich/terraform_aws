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

  ami                    = var.ec2_ami
  instance_type          = var.ec2_type
  vpc_security_group_ids = [module.Networking.default_sg_id]
  subnet_id              = flatten(module.Networking.private_subnets_id)[0]
}

resource "aws_instance" "bastion" {
  ami                         = var.ec2_ami
  key_name                    = var.ec2_key
  instance_type               = var.ec2_type
  security_groups             = [module.Networking.bastion_sg_id]
  associate_public_ip_address = true
  subnet_id                   = flatten(module.Networking.public_subnets_id)[0]

  provisioner "file" {
    source      = "./ping.sh"
    destination = "/ping.sh"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = "${file("./haris.pem")}"
      host        = "${self.public_ip}"
    }
  }
}

resource "aws_eip" "ip-test-env" {
  instance = "${aws_instance.bastion.id}"
  vpc      = true
}