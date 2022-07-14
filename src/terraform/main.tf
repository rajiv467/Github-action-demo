terraform {
  required_version = ">=1.2.0"
}

provider "aws" {
    region = "us-east-1"
  
}
resource "aws_vpc" "myvpc5" {
    cidr_block = "10.0.0.0/16"

}