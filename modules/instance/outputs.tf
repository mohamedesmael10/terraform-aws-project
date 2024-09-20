output "instance_ids" {
  value = aws_instance.instance[*].id
  description = "The IDs of the launched instances"
}

