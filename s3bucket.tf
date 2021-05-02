
resource "aws_s3_bucket" "foo" {
  bucket        = "non-aws-ip-${random_string.random_name.result}"
  force_destroy = true

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AWSCloudTrailAclCheck",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:GetBucketAcl",
            "Resource": "arn:aws:s3:::non-aws-ip-${random_string.random_name.result}"
        },

        {
            "Sid": "AWSCloudTrailWrite",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:PutObject",
            
            "Resource": "arn:aws:s3:::non-aws-ip-${random_string.random_name.result}/prefix/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control"
                }
            }
        }
    ]
}
POLICY
}


resource "aws_s3_bucket_notification" "test" {
  depends_on = [aws_s3_bucket.foo]
  bucket     = "non-aws-ip-${random_string.random_name.result}"

  lambda_function {
    lambda_function_arn = aws_lambda_function.CWLogs-Processor-Slack.arn
    events              = ["s3:ObjectCreated:*"]
    # filter_prefix       = "file-prefix"
    # filter_suffix       = "file-extension"
  }
}


