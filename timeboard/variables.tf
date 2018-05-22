variable "product_domain" {
  type        = "string"
  description = "The name of the product domain which this ASG belongs to"
}

variable "asg_name" {
  type        = "string"
  description = "The name of the auto scaling group"
}

variable "enabled" {
  type        = "string"
  default     = true
  description = "To enable this module"
}
