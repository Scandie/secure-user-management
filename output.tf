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
