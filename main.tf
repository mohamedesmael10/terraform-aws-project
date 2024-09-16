# Define the VPC
module "vpc" {
  source     = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
  vpc_name   = "my-vpc-Terraform"
}

# Public Subnets
module "public_subnet_1" {
  source                = "./modules/subnet"
  vpc_id                = module.vpc.vpc_id
  subnet_cidr           = "10.0.1.0/24"
  availability_zone     = "us-east-1a"
  map_public_ip_on_launch = true
  subnet_name           = "public-subnet-1"
}

module "public_subnet_2" {
  source                = "./modules/subnet"
  vpc_id                = module.vpc.vpc_id
  subnet_cidr           = "10.0.3.0/24"
  availability_zone     = "us-east-1b"
  map_public_ip_on_launch = true
  subnet_name           = "public-subnet-2"
}

# Private Subnets
module "private_subnet_1" {
  source                = "./modules/subnet"
  vpc_id                = module.vpc.vpc_id
  subnet_cidr           = "10.0.2.0/24"
  availability_zone     = "us-east-1a"
  map_public_ip_on_launch = false
  subnet_name           = "private-subnet-1"
}

module "private_subnet_2" {
  source                = "./modules/subnet"
  vpc_id                = module.vpc.vpc_id
  subnet_cidr           = "10.0.4.0/24"
  availability_zone     = "us-east-1b"
  map_public_ip_on_launch = false
  subnet_name           = "private-subnet-2"
}

# Internet Gateway
module "internet_gateway" {
  source = "./modules/internet_gateway"
  vpc_id = module.vpc.vpc_id
  name   = "${var.project_name}-igw"
}

# Public Route Table
module "public_route_table" {
  source              = "./modules/public_route_table"
  vpc_id              = module.vpc.vpc_id
  internet_gateway_id = module.internet_gateway.internet_gateway_id
  subnet_id          = [module.public_subnet_1.subnet_id, module.public_subnet_2.subnet_id]
  name                = "${var.project_name}-public-rt"
}

# Private Route Table
module "private_route_table" {
  source    = "./modules/private_route_table"
  vpc_id    = module.vpc.vpc_id
  subnet_id = [module.private_subnet_1.subnet_id, module.private_subnet_2.subnet_id]
  name      = "${var.project_name}-private-rt"
}

# NAT Gateway
module "nat_gateway" {
  source            = "./modules/nat_gateway"
  public_subnet_id  = module.public_subnet_1.subnet_id
  name              = "${var.project_name}-nat-gw"
}

# Security Groups
module "bastion_security_group" {
  source              = "./modules/security_group"
  vpc_id              = module.vpc.vpc_id
  name                = "${var.project_name}-bastion-sg"
  ingress_from_port   = 22
  ingress_to_port     = 22
  ingress_protocol    = "tcp"
  ingress_cidr_blocks = ["0.0.0.0/0"]
}

module "nginx_security_group" {
  source              = "./modules/security_group"
  vpc_id              = module.vpc.vpc_id
  name                = "${var.project_name}-nginx-sg"
  ingress_from_port   = 80
  ingress_to_port     = 80
  ingress_protocol    = "tcp"
  ingress_cidr_blocks = ["0.0.0.0/0"]
}

# Public Instances
resource "aws_instance" "public_instance" {
  count         = 2
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = element([module.public_subnet_1.subnet_id, module.public_subnet_2.subnet_id], count.index)
  security_groups = [module.nginx_security_group.security_group_id]
  key_name      = var.key_name

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update
              sudo apt install -y nginx
              sudo systemctl start nginx
              sudo systemctl enable nginx
              EOF

  tags = {
    Name = "${var.instance_name}-public-${count.index}"
  }
}

# Private Instances
resource "aws_instance" "private_instance" {
  count         = 2
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = element([module.private_subnet_1.subnet_id, module.private_subnet_2.subnet_id], count.index)
  security_groups = [module.bastion_security_group.security_group_id]
  key_name      = var.key_name

  tags = {
    Name = "${var.instance_name}-private-${count.index}"
  }
}

# Load Balancer
resource "aws_lb" "this" {
  name               = var.lb_name
  internal           = false
  load_balancer_type = "application"
  subnets            = [module.public_subnet_1.subnet_id, module.public_subnet_2.subnet_id]
  security_groups    = [module.nginx_security_group.security_group_id]

  tags = {
    Name = var.lb_name
  }
}

module "key" {
  source       = "./keypair"
  encrypt-kind = "RSA"
  encrypt-bits = 4096
}
