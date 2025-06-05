# --- EC2 Instances ---

# Elastic IP for the Public Web Server (separate from NAT Gateway's EIP)
resource "aws_eip" "public_web_eip" {
  domain = "vpc" # Specify that this EIP is for use within a VPC
  tags = {
    Name = var.public_instance_eip_name
    Project = "Lab"
  }
}

# Public EC2 Instance (Web Server)
resource "aws_instance" "public_web_server" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public_subnet.id # Place in public subnet
  key_name                    = var.key_pair_name
  vpc_security_group_ids      = [aws_security_group.public_web_sg.id] # Attach public SG
  associate_public_ip_address = false # Explicitly set to false, as we're associating a dedicated EIP

  tags = {
    Name = var.public_instance_name
    Project = "Lab"
  }
}

# Associate the Elastic IP with the Public Web Server
resource "aws_eip_association" "public_web_eip_assoc" {
  instance_id   = aws_instance.public_web_server.id
  allocation_id = aws_eip.public_web_eip.id
}


# Private EC2 Instance (Application Server)
resource "aws_instance" "private_app_server" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.private_subnet.id # Place in private subnet
  key_name                    = var.key_pair_name
  vpc_security_group_ids      = [aws_security_group.private_app_sg.id] # Attach private SG
  associate_public_ip_address = false # Essential for private subnets - no direct public IP

  tags = {
    Name = var.private_instance_name
    Project = "Lab"
  }
}