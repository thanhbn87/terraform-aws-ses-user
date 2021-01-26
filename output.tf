output "ses_user" {
  value       = concat(aws_iam_user.this.*.name, list(""))[0]
  description = "IAM ses username"
}

output "ses_user_arn" {
  value       = concat(aws_iam_user.this.*.arn, list(""))[0]
  description = "ARN of the IAM ses user"
}

output "access_key" {
  value       = concat(aws_iam_access_key.this.*.id, list(""))[0]
  description = "IAM Access Key of the created user, used as the STMP user name"
}

output "ses_smtp_password_v4" {
  value       = concat(aws_iam_access_key.this.*.ses_smtp_password_v4, list(""))[0]
  description = "The secret access key converted into an SES SMTP password by applying AWS's documented Sigv4 conversion algorithm"
  sensitive   = false
}