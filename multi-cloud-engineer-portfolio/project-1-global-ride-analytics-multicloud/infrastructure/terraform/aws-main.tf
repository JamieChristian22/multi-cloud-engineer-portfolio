provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "global_ride_raw" {
  bucket = var.raw_bucket_name
}

resource "aws_s3_bucket" "global_ride_curated" {
  bucket = var.curated_bucket_name
}

// TODO: Glue, IAM, Athena/Redshift, etc.
