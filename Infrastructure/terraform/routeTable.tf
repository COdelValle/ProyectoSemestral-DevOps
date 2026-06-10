resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "${var.project_name}-route-table"
  }
}

# ASSOCIATIONS 

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.subnet-1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.subnet-2.id
  route_table_id = aws_route_table.public.id
}