resource "aws_instance" "instance" {
  count         = var.instance_count
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_ids[count.index]
  vpc_security_group_ids = var.security_group_ids
  key_name      = var.key_name
  associate_public_ip_address = var.associate_public_ip_address

  user_data = var.user_data 
 
  tags = {
    Name = "${var.instance_name}-${count.index}"
  }
}
