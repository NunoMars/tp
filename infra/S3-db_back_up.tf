
resource "aws_s3_bucket" "db-backup-site-voyance" {
  bucket = "db-backup-site-voyance"
  tags = {
    Name        = "db-backup-site-voyance"
    Environment = "Production"
  }
}

resource "aws_s3_bucket_cors_configuration" "db-backup-site-voyance-cors" {
  bucket = aws_s3_bucket.db-backup-site-voyance.bucket
  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST", "DELETE"]
    allowed_origins = ["*"]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
}
