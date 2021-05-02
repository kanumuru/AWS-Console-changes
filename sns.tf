resource "aws_sns_topic" "user_updates" {
  name = "user-updates-topic"
}


resource "null_resource" "email_subscription" {
  depends_on = [aws_sns_topic.user_updates]

  provisioner "local-exec" {
    command = "${local.aws_cli_command} sns subscribe --topic-arn ${aws_sns_topic.user_updates.arn} --protocol email --notification-endpoint ${var.email_address}"
  }
  triggers = {
    email_id = var.email_address

    topic_arn = aws_sns_topic.user_updates.arn
  }
}

