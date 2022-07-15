
variable "aws_access_key" {
  type    = string
  default = "AKIA4IKFXY6NOHQTPD6I"
}

variable "aws_secret_key" {
  type    = string
  default = "8rCIfCcRpvQKRmAuYOG94BvaM9M9yiqBvLD7FF0L"
}

data "amazon-ami" "ubuntu" {
  access_key = "${var.aws_access_key}"
  filters = {
    name                = "ubuntu/images/*ubuntu-jammy-22.04-amd64-server-*"
    root-device-type    = "ebs"
    virtualization-type = "hvm"
  }
  most_recent = true
  owners      = ["099720109477"]
  region      = "us-east-1"
  secret_key  = "${var.aws_secret_key}"
}

locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

source "amazon-ebs" "ubuntu" {
  access_key    = "${var.aws_access_key}"
  ami_name      = "packer-example ${local.timestamp}"
  instance_type = "t2.micro"
  region        = "us-east-1"
  secret_key    = "${var.aws_secret_key}"
  source_ami    = "${data.amazon-ami.ubuntu.id}"
  ssh_username  = "ubuntu"
}

build {
  sources = ["source.amazon-ebs.ubuntu"]
}
