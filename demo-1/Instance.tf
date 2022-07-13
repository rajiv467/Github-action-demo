resource "aws_instance" "Example" {
    ami = var.amis[var.aws_region]
    instance_type = "t2.micro"
  
}