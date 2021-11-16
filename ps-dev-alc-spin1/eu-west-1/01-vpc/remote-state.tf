data "terraform_remote_state" "random_string" {
  backend = "s3" 
  config = {
    region         = "us-west-2"
    bucket         = "armory-alc-state"
    key            = "terraform/eu-west-1/random.tfstate"
    dynamodb_table = "armory-alc-state-lock"
    encrypt        = "true"
  }
}
