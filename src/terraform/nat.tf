resource "aws_eip" "my-eip" {
    vpc = true
  
}

resource "aws_nat_gateway" "my-nat" {
    allocation_id = aws_eip.my-eip.id
    subnet_id = aws_subnet.main-public-1.id
    depends_on = [aws_internet_gateway.my-Igw]  
}

resource "aws_route_table" "private-nat" {
    vpc_id = aws_vpc.myvpc.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.my-nat.id
  
}
}

resource "aws_route_table_association" "private_nat_association-1a" {
    subnet_id = aws_subnet.main-private-1.id
    route_table_id = aws_route_table.private-nat.id
  
}


resource "aws_route_table_association" "private_nat_association-1b" {
    subnet_id = aws_subnet.main-private-2.id
    route_table_id = aws_route_table.private-nat.id
  
}

resource "aws_route_table_association" "private_nat_association-1c" {
    subnet_id = aws_subnet.main-private-3.id
    route_table_id = aws_route_table.private-nat.id
  
}