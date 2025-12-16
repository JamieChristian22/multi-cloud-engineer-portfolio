terraform {
  backend "s3" {
    bucket         = "jamie-terraform-state-bucket"
    key            = "mission-cloud/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "jamie-terraform-locks"
    encrypt        = true
  }
}
