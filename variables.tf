variable "email_address" {
  description = "The email address to send data to"
  type        = string
  default     = "rajeshkanumuru@gmail.com" # Takes input dynmically
}

variable "return_subscription_arn" {
  description = "Sets whether the response from the Subscribe request includes the subscription ARN, even if the subscription is not yet confirmed."
  type        = bool
  default     = false
}
