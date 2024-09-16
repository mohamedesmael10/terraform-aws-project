resource "aws_route_table" "this" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.internet_gateway_id
  }

  tags = {
    Name = var.name
  }
}

resource "aws_route_table_association" "public_association" {
  count      = length(var.subnet_id)
  subnet_id  = var.subnet_id[count.index]
  route_table_id = aws_route_table.this.id
}
