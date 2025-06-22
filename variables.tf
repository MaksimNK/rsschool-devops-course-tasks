variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "azs" {
  description = "List of AZs; length must match public_subnets and private_subnets"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "key_name" {
  description = "EC2 Key Pair name for SSH"
  type        = string
}

variable "bastion_allowed_ips" {
  description = "CIDR blocks allowed for SSH to bastion"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "ec2_ami" {
  description = "AMI ID for NAT instance (Ubuntu LTS)"
  type        = string
}

variable "instance_type" {
  description = "Instance type for NAT"
  type        = string
  default     = "t3.micro"
}

variable "common_course_tag" {
  description = "Custom tag"
  type        = string
  default     = "terraform-course-2025"
}
