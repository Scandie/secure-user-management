output "admin_user_password" {
  value     = aws_iam_user_login_profile.admin_user_profile.password
  sensitive = true
}

output "power_user_vanya_password" {
  value     = aws_iam_user_login_profile.power_user_vanya_profile.password
  sensitive = true
}

output "power_user_yura_password" {
  value     = aws_iam_user_login_profile.power_user_yura_profile.password
  sensitive = true
}
