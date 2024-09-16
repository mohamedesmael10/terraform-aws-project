variable "vpc_id" {
  description = "The ID of the VPC."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the private subnet."
  type        = list(string)
}

variable "name" {
  description = "The name of the Route Table."
  type        = string
}
