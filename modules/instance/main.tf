resource "aws_instance" "nginx" {
  count         = var.instance_count
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_ids[count.index]
  security_groups = [var.security_group_id]
  key_name      = var.key_name

  user_data = var.user_data != "" ? var.user_data : null
 
  tags = {
    Name = "${var.instance_name}-${count.index}"
  }
}
