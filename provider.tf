terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
# This block configures the backend for storing the Terraform state.
# Uncomment and configure the backend block below if you want to use S3 for state management.
# backend "s3" {
#   bucket         = "your-terraform-state-bucket"
#   key            = "terraform.tfstate"
#   region         = "us-east-1"
#   dynamodb_table = "terraform-lock-table"
# }

provider "aws" {
  region = "us-east-1"
  profile = "UDPERSONAL" # UDPERSONAL is the name of the AWS CLI profile I've saved with my credentials.
  # Uncomment the following line if you want to use a specific access key and secret key
}