variable "instance_count" {
  description = "Number of EC2 instances to launch"
  type        = number
}

variable "ami_id" {
  description = "AMI ID for the instances"
  type        = string
}

variable "instance_type" {
  description = "Instance type"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs where instances will be launched"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group ID to assign to the instances"
  type        = string
}

variable "instance_name" {
  description = "Name tag for instances"
  type        = string
}

variable "user_data" {
  description = "The user data script to run on instance launch"
  type        = string
  default     = ""
}