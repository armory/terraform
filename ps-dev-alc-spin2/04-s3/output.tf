output "s3_bucket_id" {
  value = data.aws_s3_bucket.selected.id
}

output "s3_bucket_arn" {
  value = data.aws_s3_bucket.selected.arn
}

output "s3_bucket_domain_name" {
  value = data.aws_s3_bucket.selected.bucket_domain_name
}
