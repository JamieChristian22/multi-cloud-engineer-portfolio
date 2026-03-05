
terraform {
  backend "s3" {
    bucket         = "mc-terraform-state-2026"
    key            = "foundation/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "mc-terraform-locks"
    encrypt        = true
  }
}
