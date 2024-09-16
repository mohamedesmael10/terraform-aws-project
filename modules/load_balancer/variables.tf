variable "lb_name" {
  description = "Name of the Load Balancer"
  type        = string
}

variable "subnet_ids" {
  description = "Subnets for the Load Balancer"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group for the Load Balancer"
  type        = string
}

variable "target_group_name" {
  description = "Name of the target group"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID for the target group"
  type        = string
}

variable "instance_count" {
  description = "Number of target instances"
  type        = number
}

variable "instance_ids" {
  description = "List of instance IDs to attach to the target group"
  type        = list(string)
}
