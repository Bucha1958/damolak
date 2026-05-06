provider "aws" {
  region = "us-west-2"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-amd64-server-*"]
  }

  owners = ["099720109477"]
}

module "vpc" {
  source      = "./modules/vpc"
  cidr_block  = "172.31.0.0/16"
  name        = "damolak"
}

module "subnet" {
  source        = "./modules/subnet"
  vpc_id        = module.vpc.vpc_id
  public_subnets = [
  "172.31.10.0/24",
  "172.31.12.0/24"
  ]

  private_subnets = [
    "172.31.11.0/24",
    "172.31.13.0/24"
  ]

  azs = [
    "us-west-2a",
    "us-west-2b"
  ]

}

module "security" {
  source = "./modules/security"
  vpc_id = module.vpc.vpc_id
  name   = "damolak-sg"
}

resource "aws_key_pair" "this" {
  key_name   = "damolak-key"
  public_key = file("~/.ssh/id_ed25519.pub")
}


module "ec2" {
  source         = "./modules/ec2"
  ami            = data.aws_ami.ubuntu.id
  instance_type  = "t3.small"
  subnet_id      = module.subnet.public_subnet_ids[0]
  sg_id          = module.security.sg_id
  key_name       = aws_key_pair.this.key_name
  name           = "damolak_instance"
}

module "ecr" {
  source = "./modules/ecr"

  repositories = [
    "app-a",
    "app-b",
    "app-c",
    "app-d"
  ]
}

module "eks" {
  source = "./modules/eks"

  cluster_name = "damolak-eks"

  subnet_ids = module.subnet.private_subnet_ids
}