#
# Provider Configuration
#

provider "aws" {
  version = "~> 1.60.0"
  region = "${var.provider-region}"
  profile = "${var.provider-profile}"
}

# Using these data sources allows the configuration to be
# generic for any region.
data "aws_region" "current" {}
