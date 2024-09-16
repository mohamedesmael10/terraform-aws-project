resource "aws_route_table" "this" {
  vpc_id = var.vpc_id

  tags = {
    Name = var.name
  }
}

resource "aws_route_table_association" "private_association" {
  count      = length(var.subnet_id)
  subnet_id  = var.subnet_id[count.index]
  route_table_id = aws_route_table.this.id
}
