resource "aws_elasticache_subnet_group" "elasticache-subnet-grp" {
  name       = "elasticache-subnet-grp"
  subnet_ids = "${var.subnet-ids}"
}

resource "aws_elasticache_replication_group" "elasticache-repl-grp" {
  automatic_failover_enabled    = true
  availability_zones            = "${var.availability_zones}"
  replication_group_id          = "spin-repl-grp"
  replication_group_description = "Replication group for Elasticache Spin"
  node_type                     = "cache.r5.large"
  number_cache_clusters         = 2
  parameter_group_name          = "${aws_elasticache_parameter_group.default.id}"
  engine                        = "redis"
  port                          = 6379
  subnet_group_name = "${aws_elasticache_subnet_group.elasticache-subnet-grp.name}"
  security_group_ids = "${var.security_group_ids}"
  lifecycle {
    ignore_changes = ["number_cache_clusters"]
  }
}

resource "aws_elasticache_parameter_group" "default" {
  name   = "redisspinnaker5"
  family = "redis5.0"
  description = "modified PG for redis, allows permisions for clouddriver initial commands"

  parameter {
    name  = "notify-keyspace-events"
    value = "gxE"
  }
}
