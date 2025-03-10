resource "aws_iam_user" "admin_user" {
  name = "admin"
}

resource "aws_iam_user_policy_attachment" "admin_user_policy" {
  user       = aws_iam_user.admin_user.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_user_login_profile" "admin_user_profile" {
  user                    = aws_iam_user.admin_user.name
  password_length         = 16
  password_reset_required = true
}

# Create power users
resource "aws_iam_user" "power_user_vanya" {
  name = "vanya"
}

resource "aws_iam_user_login_profile" "power_user_vanya_profile" {
  user                    = aws_iam_user.power_user_vanya.name
  password_length         = 16
  password_reset_required = true
}

resource "aws_iam_user_policy_attachment" "power_user_vanya_policy" {
  user       = aws_iam_user.power_user_vanya.name
  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}

resource "aws_iam_user" "power_user_yura" {
  name = "yura"
}


resource "aws_iam_user_login_profile" "power_user_yura_profile" {
  user                    = aws_iam_user.power_user_yura.name
  password_length         = 16
  password_reset_required = true
}

resource "aws_iam_user_policy_attachment" "power_user_yura_policy" {
  user       = aws_iam_user.power_user_yura.name
  policy_arn = "arn:aws:iam::aws:policy/PowerUserAccess"
}
