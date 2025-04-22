# Public Subnets
resource "aws_subnet" "public" {
  for_each = { for idx, cidr in var.public_subnets : idx => cidr }

  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value
  availability_zone       = element(var.availability_zones, index(keys(var.public_subnets), each.key))
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet ${each.key}"
  }
}

# Private Subnets
resource "aws_subnet" "private" {
  for_each = { for idx, cidr in var.private_subnets : idx => cidr }

  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value
  availability_zone       = element(var.availability_zones, index(keys(var.private_subnets), each.key))
  map_public_ip_on_launch = false

  tags = {
    Name = "Private Subnet ${each.key}"
  }
}
