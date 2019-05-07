#
# Provider Configuration
#

provider "aws" {
  version = "~> 1.42.0"
  region = "us-west-2"      # Edit region, if necessary
  profile = "<<Enter A Profile to use>>"
}

# Using these data sources allows the configuration to be
# generic for any region.
data "aws_region" "current" {}

data "aws_availability_zones" "available" {}