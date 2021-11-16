data "terraform_remote_state" "random_string" {
  backend = "s3" 
  config = {
    region         = "us-west-2"
    bucket         = "armory-alc-state"
    key            = "terraform/us-west-2/random.tfstate"
    dynamodb_table = "armory-alc-state-lock"
    encrypt        = "true"
  }
}

data "terraform_remote_state" "vpc" {
  backend = "s3" 
  config = {
    region         = "us-west-2"
    bucket         = "armory-alc-state"
    key            = "terraform/us-west-2/vpc.tfstate"
    dynamodb_table = "armory-alc-state-lock"
    encrypt        = "true"
  }
}

data "terraform_remote_state" "sg" {
  backend = "s3" 
  config = {
    region         = "us-west-2"
    bucket         = "armory-alc-state"
    key            = "terraform/us-west-2/sg.tfstate"
    dynamodb_table = "armory-alc-state-lock"
    encrypt        = "true"
  }
}

