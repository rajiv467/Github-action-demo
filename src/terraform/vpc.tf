resource "aws_vpc" "myvpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_support = "true"
    enable_dns_hostnames = "true"
    instance_tenancy = "default"
    tags={
        name = "my-vpc"
        terraform  = true
    }
}
  #Subnet
  
resource "aws_subnet" "main-public-1" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.1.0/24"
    map_public_ip_on_launch = true
    availability_zone = "eu-west-1a"
    tags = {
      name = "main-public-1"
      creationdate =  "aws_vpc.myvpc.create_date"
    }
}

resource "aws_subnet" "main-public-2" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.2.0/24"
    map_public_ip_on_launch = true
    availability_zone = "eu-west-1b"
}

resource "aws_subnet" "main-public-3" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.3.0/24"
    map_public_ip_on_launch = true
    availability_zone = "eu-west-1c"
}

resource "aws_subnet" "main-private-1" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.4.0/24"
    map_public_ip_on_launch = false
    availability_zone = "eu-west-1a"
}

resource "aws_subnet" "main-private-2" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.5.0/24"
    map_public_ip_on_launch = false
    availability_zone = "eu-west-1b"
}

resource "aws_subnet" "main-private-3" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.6.0/24"
    map_public_ip_on_launch = false
    availability_zone = "eu-west-1c"
}


#internet gateway

resource "aws_internet_gateway" "my-Igw" {
    vpc_id = aws_vpc.myvpc.id

    tags = {
        terraform = true
    }
  
}

#route table

resource "aws_route_table" "my-rt" {
    vpc_id = aws_vpc.myvpc.id


    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my-Igw.id
    }  

    tags = {
      terraform = true
    }
}

#route table association

resource "aws_route_table_association" "rt-association-1a" {

    subnet_id = aws_subnet.main-public-1.id
    route_table_id = aws_route_table.my-rt.id
  
}

resource "aws_route_table_association" "rt-association-1b" {

    subnet_id = aws_subnet.main-public-2.id
    route_table_id = aws_route_table.my-rt.id
  
}

resource "aws_route_table_association" "rt-association-1c" {

    subnet_id = aws_subnet.main-public-3.id
    route_table_id = aws_route_table.my-rt.id
  
}