variable "instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
  default     = 1
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EC2 instances"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs to associate with the EC2 instances"
  type        = list(string)
}

variable "key_name" {
  description = "Key name for the EC2 instances"
  type        = string
}

variable "user_data" {
  description = "User data to initialize the EC2 instances"
  type        = string
  default     = ""
}

variable "instance_name" {
  description = "Base name for the EC2 instances"
  type        = string
}
