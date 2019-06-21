#
# Outputs: there are really no terraform outputs, these files are stored in an S3 bucket
#

locals {
  
  endpoint = <<ENDPOINT
    	${aws_elasticache_replication_group.elasticache-repl-grp.primary_endpoint_address}
  ENDPOINT
}

output "endpoint" {
  value = "${local.endpoint}"
}

