variable "aws_region" {
  description = "AWS region to create resources"
  default     = "eu-west-1"
}

variable "aws_access_key" {
  
}

variable "aws_secret_key" {
}


variable "vpc_id" {
  
}

variable "cidr_block" {
    type = string
    default = "10.0.0.0/16"
}


variable "public_key" {
    default = "mykey.pub"
}

variable "private_key" {
  default = "mykey"
  
}