resource "aws_cloudtrail" "foobar" {
  name                          = "non-aws-ip-${random_string.random_name.result}-trail"
  s3_bucket_name                = aws_s3_bucket.foo.id
  s3_key_prefix                 = "prefix"
  include_global_service_events = true
  enable_log_file_validation    = true
}
