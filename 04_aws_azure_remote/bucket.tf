resource "aws_s3_bucket" "gp-bucket" {
  bucket = "giopellizzoni-remote-state"
}

resource "aws_s3_bucket_versioning" "gp-bkt-versioning" {
  bucket = aws_s3_bucket.gp-bucket.bucket
  versioning_configuration {
    status = "Enabled"
  }
}
