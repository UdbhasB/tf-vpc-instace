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
    type = string
}
variable "app_sub_name" {
    type = string
}
variable "db_sub_cidr" {
    type = string
}
variable "db_sub_name" {
    type = string
}
variable "pub_route_name" {
    type = string
}
variable "pri_route_name" {
    type = string
}
variable "my_igw_name" {
    type = string
}
variable "vpc_route_cidr" {
    type = string
}
variable "elastic_ip_name" {
    type = string
}
variable "my_natgw_name" {
    type = string
}
variable "natgw_cidr" {
    type = string
}

