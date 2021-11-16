terraform {
  required_version = ">= 0.12.0"

  backend "s3" {
    region         = "us-west-2"
    bucket         = "armory-alc-state"
    key            = "terraform/us-west-2/s3.tfstate"
    dynamodb_table = "armory-alc-state-lock"
    encrypt        = "true"
  }
}
