resource "aws_lambda_function" "CWLogs-Processor-Slack" {
  filename         = "awsconsoleactions.zip"
  function_name    = "SSM-operator-to-slack-${random_string.random_name.result}"
  role             = aws_iam_role.lambda_role.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.7"
  timeout          = 10
  source_code_hash = base64sha256("awsconsoleactions.zip")

}


resource "aws_lambda_permission" "test" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.CWLogs-Processor-Slack.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = "arn:aws:s3:::non-aws-ip-${random_string.random_name.result}"
}


