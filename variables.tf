variable "aws_profile" {
  default = "default"
}

variable "aws_region" {
  default = "eu-west-1"
}


# VPC VARS

# VPC CIDR blocks
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

# Subnet CIDRs
# Public Subnets
variable "public_subnets" {
  default = {
    "a" = "10.0.1.0/24"
    "b" = "10.0.2.0/24"
  }
}

# Private Subnets
variable "private_subnets" {
  default = {
    "a" = "10.0.3.0/24"
    "b" = "10.0.4.0/24"
  }
}

# Availability Zones
variable "availability_zones" {
  default = ["eu-west-1a", "eu-west-1b"]
}

# AMI for NAT Instance (Amazon Linux 2)
variable "nat_ami" {
  default = "ami-08f9a9c699d2ab3f9"
}
