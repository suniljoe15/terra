resource "aws_route_table" "web-rt" {
  vpc_id = aws_vpc.web-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.web-igw.id
  }

  tags = {
    Name = "Terraform-RT"
  }
}

resource "aws_route_table_association" "web-rta1" {
  subnet_id      = aws_subnet.web-pub-sub-1a.id
  route_table_id = aws_route_table.web-rt.id

}

resource "aws_route_table_association" "web-rta2" {
  subnet_id      = aws_subnet.web-pub-sub-1b.id
  route_table_id = aws_route_table.web-rt.id

}
