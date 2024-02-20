terraform {
  required_version = "1.7.3"

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.37.0"
    }
  }
}

provider "aws" {
    region = "us-east-1"
    profile = "terraform001"
}

resource "aws_s3_bucket" "my-test-bucket" {
  bucket = "my-tf-test-bucket-terraform222222123123"
  
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
    Managedby = "Terraform"
  }
}

resource "aws_s3_bucket_ownership_controls" "ownershipControls" {
  bucket = aws_s3_bucket.my-test-bucket.bucket
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "curso_bucket_acl" {
  depends_on = [ aws_s3_bucket_ownership_controls.ownershipControls ]
  bucket = aws_s3_bucket.my-test-bucket.bucket
  acl    = "private"
}
