variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
  default = "eu-central-1"
}

variable "region" {
  default = "eu-central-1"
}

variable "environment" {
  type        = string
  description = "Deployment Environment"
  default     = "Akvelon"
}

variable "vpc_cidr" {
  description = "CIDR block of the vpc"
  default     = "10.0.0.0/16"
}

variable "public_subnets_cidr" {
  type        = list(any)
  description = "CIDR block for Public Subnet"
  default     = ["10.0.1.0/24"]
}

variable "private_subnets_cidr" {
  type        = list(any)
  description = "CIDR block for Private Subnet"
  default     = ["10.0.10.0/24"]
}

# variable "private_subnet_id" {
#   description = "Private subnet id"
#   default = module.Networking.private_subnets_id
# }

variable "ec2_private_ips" {
  description = "EC2 private instance ips"
  default = ["10.0.10.1"]
}

# variable "aws_security_groups" {
#   description = "Aws security groups"
#   default = [module.Networking.default_sg_id]
# }

variable "ec2_public_key" {
  description = "EC2 public instance key"
  default = "haris"
}
