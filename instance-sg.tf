# --- EC2 Security Groups ---

# Security Group for Public Web Server
resource "aws_security_group" "public_web_sg" {
  name        = var.public_sg_name
  description = "Allow inbound HTTP/HTTPS/SSH from anywhere, outbound to anywhere"
  vpc_id      = aws_vpc.my_vpc.id

  # Inbound Rule: Allow HTTP (Port 80) from anywhere (0.0.0.0/0)
  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Inbound Rule: Allow HTTPS (Port 443) from anywhere (0.0.0.0/0)
  ingress {
    description = "HTTPS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Inbound Rule: Allow SSH (Port 22) from anywhere (0.0.0.0/0) - For lab purposes.
  # In production, restrict this to your office IP or a VPN CIDR.
  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound Rule: Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # -1 means all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.public_sg_name
    Project = "Lab"
  }
}

# Security Group for Private App Server
resource "aws_security_group" "private_app_sg" {
  name        = var.private_sg_name
  description = "Allow SSH from Public Web SG, outbound to anywhere"
  vpc_id      = aws_vpc.my_vpc.id

  # Inbound Rule: Allow SSH (Port 22) only from the Public Web Server's Security Group
  # This makes the public server a "jump host" to reach the private server.
  ingress {
    description     = "SSH from public web server"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.public_web_sg.id] # Reference the public SG by its ID
  }

  # Outbound Rule: Allow all outbound traffic
  # This relies on the Private Route Table and NAT Gateway for internet access.
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.private_sg_name
    Project = "Lab"
  }
}


