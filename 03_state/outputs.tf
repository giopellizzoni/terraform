output "bucket_id" {
  value       = aws_s3_bucket.bucket-gio.id
  description = "The ID of the bucket"
}

output "bucket_arn" {
  value       = aws_s3_bucket.bucket-gio.arn
  description = "The ARN of the bucket"
}