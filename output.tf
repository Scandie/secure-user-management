# Output initial passwords for admin users dynamically
output "admin_user_passwords" {
  value = {
    for user, profile in aws_iam_user_login_profile.admin_user_profile :
    user => profile.password
  }
  sensitive = true
}

# Output initial passwords for power users dynamically
output "power_user_passwords" {
  value = {
    for user, profile in aws_iam_user_login_profile.power_user_profiles :
    user => profile.password
  }
  sensitive = true
}



# VPC Details

output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = [for s in aws_subnet.public : s.id]
}

output "private_subnet_ids" {
  value = [for s in aws_subnet.private : s.id]
}

output "nat_instance_ip" {
  value = aws_instance.nat.public_ip
}

output "nat_instance_network_interface" {
  value = aws_instance.nat.primary_network_interface_id
}

# Keys
output "key_pair_name" {
  value = aws_key_pair.nat_key.key_name
}

output "private_key_path" {
  value     = local_file.nat_private_key.filename
  sensitive = true
}
