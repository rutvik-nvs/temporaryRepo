variable "aws_region" {
  type        = string
  description = "The AWS region where resources will be created"
  default     = "us-east-1"
}

variable "ansible_component_version" {
  type        = string
  description = "The semantic version for the components (e.g., 1.0.0)"
  default     = "1.0.0"
}