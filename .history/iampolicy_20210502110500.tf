# resource "aws_iam_role_policy_attachment" "lambda-basic-exec-role" {
#   role       = aws_iam_role.lambda_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
# }

# resource "aws_iam_role_policy_attachment" "lambda-basic-exec-role1" {
#   role = aws_iam_role.lambda_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
# }



resource "aws_iam_role_policy" "ec2_cw_policy" {
  name = "lambda_s3_sns_policy-${random_string.random_name.result}"
  role = aws_iam_role.lambda_role.name

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "sns:*",
                "s3:Get*",
                "s3:List*"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}