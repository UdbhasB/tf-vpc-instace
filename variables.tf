variable "region" {
  description = "The AWS region to deploy the VPC and EC2 instance."
  type        = string
    #default     = "us-east-1"  # Default region can be set here if needed or can be mentioned on .tfvars file
  
}

variable "availability_zone1" {
  type = string
}

variable "vpc_cidr" {
    type = string
    description = "The CIDR block for the VPC."
  
}

variable "vpc_name" {
  type        = string
  description = "The CIDR block for the public subnet."
}

variable "web_subnet_cidr" {
  type        = string
  description = "The CIDR block for the public subnet."
  
}

variable "web_subnet_name" {
  type        = string
  description = "The name of the public subnet."
  
}
variable "app_sub_cidr" {
    description = "The CIDR block for the application subnet."
    type = string
}
variable "app_sub_name" {
    description = "The CIDR block for the application subnet."
    type = string
}
variable "db_sub_cidr" {
    description = "The CIDR block for the database subnet."
    type = string
}
variable "db_sub_name" {
    description = "The name of the database subnet."
    type = string
}
variable "pub_route_name" {
    description = "The name of the public route table."
    type = string
}
variable "pri_route_name" {
    description = "The name of the private route table."
    type = string
}
variable "my_igw_name" {

    type = string
}
variable "vpc_route_cidr" {
    description = "The CIDR block for the VPC route."
    type = string
}
variable "elastic_ip_name" {
    description = "The name of the Elastic IP for the public instance."
    type = string
}
variable "my_natgw_name" {
    description = "The name of the NAT Gateway."
    type = string
}
variable "natgw_cidr" {
    description = "The CIDR block for the NAT Gateway route."
    type = string
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instances (e.g., Amazon Linux 2/2023)."
  type        = string
}

variable "instance_type" {
  description = "The EC2 instance type (e.g., t2.micro, t3.micro)."
  type        = string
  default     = "t2.micro" # Good for Free Tier
}

variable "key_pair_name" {
  description = "The name of an existing EC2 Key Pair for SSH access."
  type        = string
}

variable "public_instance_name" {
  description = "Name tag for the public EC2 instance."
  type        = string
}

variable "private_instance_name" {
  description = "Name tag for the private EC2 instance."
  type        = string
}

variable "public_sg_name" {
  description = "Name tag for the public EC2 security group."
  type        = string
}

variable "private_sg_name" {
  description = "Name tag for the private EC2 security group."
  type        = string
}

variable "public_instance_eip_name" {
  description = "Name tag for the Elastic IP associated with the public instance."
  type        = string
}

