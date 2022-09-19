# variable "aws_access_key" {
# }

# variable "aws_secret_key" {
# }


variable "aws_region" {
    type = string
    default = "us-east-1"
  
}


variable "amis" {
    type = map(string)
    default = {
        us-east-1 = "ami-05fa00d4c63e32376"
        //us-west-2 = "ami-123"
        //eu-west-1 = "ami-xyz"
    }
  
}
