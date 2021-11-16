terraform {
  required_version = ">= 0.12.0"

  backend "s3" {
    region         = "us-west-2"
    bucket         = "armory-alc-state"
    key            = "terraform/eu-west-1/vpc.tfstate"
    dynamodb_table = "armory-alc-state-lock"
    encrypt        = "true"
  }
}
