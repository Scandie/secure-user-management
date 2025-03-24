resource "aws_iam_account_password_policy" "strict_policy" {
  minimum_password_length        = 16
  require_numbers                = true
  require_symbols                = true
  require_uppercase_characters   = true
  require_lowercase_characters   = true
  allow_users_to_change_password = true
  max_password_age               = 90
  password_reuse_prevention      = 5
}
