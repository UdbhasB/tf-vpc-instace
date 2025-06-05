#main VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
    Project = "Lab"
  }
  
}
# VPC public subnet for web tier
resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = var.web_subnet_cidr
  availability_zone = var.availability_zone1
  map_public_ip_on_launch = true
  tags = {
    Name = var.web_subnet_name
    Project = "Lab"
  }
  
}
# VPC private subnet for app tier
resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = var.app_sub_cidr
  availability_zone = var.availability_zone1
  tags = {
    Name = var.app_sub_name
    Project = "Lab"
  }
  
}   
# DB subnet for App tier
resource "aws_subnet" "db_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.db_sub_cidr
  availability_zone       = var.availability_zone1
  map_public_ip_on_launch = true
  tags = {
    Name = var.db_sub_name
    Project = "Lab"
  }
}

# Public Route Table
resource "aws_route_table" "pub_route" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = var.pub_route_name
    Project = "Lab"
  }
}
# Private Route Table
resource "aws_route_table" "pri_route" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = var.pri_route_name
    Project = "Lab"
  }
}

# Public Route Table Association
resource "aws_route_table_association" "pub_route_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.pub_route.id
}

# Private Route Table Association
resource "aws_route_table_association" "pri_route_assoc" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.pri_route.id
}

# DB subnet association to private route
resource "aws_route_table_association" "pri_route_assoc_db" {
  subnet_id      = aws_subnet.db_subnet.id
  route_table_id = aws_route_table.pri_route.id
}

# VPC Internet Gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = var.my_igw_name
    Project = "Lab"
  }
}

# VPC Route
resource "aws_route" "my_vpc_route" {
  route_table_id         = aws_route_table.pub_route.id
  destination_cidr_block = var.vpc_route_cidr
  gateway_id             = aws_internet_gateway.my_igw.id
}

# Elastic IP for VPC NAT Gateway
resource "aws_eip" "elastic_ip" {
  domain = "vpc"
  tags = {
    Name = var.elastic_ip_name
    Project = "Lab"
  }
}

# NAT Gateway creation
resource "aws_nat_gateway" "my_nat_gw" {
  allocation_id = aws_eip.elastic_ip.id
  subnet_id     = aws_subnet.public_subnet.id
  tags = {
    Name = var.my_natgw_name
    Project = "Lab"
  }
}

# Associating NAT GW to Private Route
resource "aws_route" "my_nat_route" {
  route_table_id         = aws_route_table.pri_route.id
  destination_cidr_block = var.natgw_cidr
  nat_gateway_id         = aws_nat_gateway.my_nat_gw.id
}