resource "aws_s3_bucket" "container_webapp_bucket" {
  bucket=var.BUCKET_NAME
  acl = "private"
  force_destroy = true
  tags = {
    Project = var.PROJECT_NAME
    Name = format("%s-bucket",var.PROJECT_NAME)
    Env = var.ENVIRONMENT
  }
}
output "BUCKET_NAME" {
  value = aws_s3_bucket.container_webapp_bucket.id
  }