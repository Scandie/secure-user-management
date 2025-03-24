locals {
  admins      = ["admin"]
  power_users = ["vanya", "yura"]
}

resource "aws_iam_user" "admin_users" {
  for_each = toset(local.admins)

  name = each.value
}

resource "aws_iam_user_policy_attachment" "admin_user_policy" {
  for_each = aws_iam_user.admin_users

  user       = each.value.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_user_login_profile" "admin_user_profile" {
  for_each = aws_iam_user.admin_users

  user                    = each.value.name
  password_length         = 16
  password_reset_required = true
}


resource "aws_iam_group" "power_user_group" {
  name = "PowerUsers"
}

resource "aws_iam_group_policy_attachment" "power_user_group_policy" {
  group      = aws_iam_group.power_user_group.name
  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}


resource "aws_iam_user" "power_users" {
  for_each = toset(local.power_users)

  name = each.value
}

resource "aws_iam_user_login_profile" "power_user_profiles" {
  for_each = aws_iam_user.power_users

  user                    = each.value.name
  password_length         = 16
  password_reset_required = true
}

resource "aws_iam_group_membership" "power_user_membership" {
  name  = "power-users"
  group = aws_iam_group.power_user_group.name
  users = [for user in aws_iam_user.power_users : user.name]
}


resource "aws_iam_group_policy_attachment" "power_user_mfa_policy" {
  group      = aws_iam_group.power_user_group.name
  policy_arn = aws_iam_policy.require_mfa.arn
}

resource "aws_iam_user_policy_attachment" "require_mfa_for_admin" {
  for_each   = aws_iam_user.admin_users
  user       = each.value.name
  policy_arn = aws_iam_policy.require_mfa.arn
}