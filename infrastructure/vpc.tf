
resource "aws_vpc" "container_webapp_vpc" {
  cidr_block       = var.VPC_CIDR_BLOCK
  instance_tenancy = "default"
  enable_dns_hostnames = true
  tags = {
    Project = var.PROJECT_NAME
    Name = format("%s-vpc",var.PROJECT_NAME)
    Env = var.ENVIRONMENT
  }
}

resource "aws_subnet" "container_webapp_subnet" {
  vpc_id     = aws_vpc.container_webapp_vpc.id
  cidr_block = var.SUBNET_VAR.CIDR_BLOCK
  map_public_ip_on_launch = true
   availability_zone = var.SUBNET_VAR.AVAILABILITY_ZONE

  tags = {
    Project = var.PROJECT_NAME
    Name = format("%s-subnet",var.PROJECT_NAME)
    Env = var.ENVIRONMENT
  }
}

resource "aws_internet_gateway" "container_webapp_igw" {
  vpc_id = aws_vpc.container_webapp_vpc.id
  tags = {
    Project = var.PROJECT_NAME
    Name = format("%s-igw",var.PROJECT_NAME)
    Env = var.ENVIRONMENT
  }
}
resource "aws_route_table" "container_webapp_route_table" {
  vpc_id = aws_vpc.container_webapp_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.container_webapp_igw.id
  }

  tags = {
    Project = var.PROJECT_NAME
    Name = format("%s-routetable",var.PROJECT_NAME)
    Env = var.ENVIRONMENT
  }
}
resource "aws_route_table_association" "route_association" {
  subnet_id      = aws_subnet.container_webapp_subnet.id
  route_table_id = aws_route_table.container_webapp_route_table.id
}

