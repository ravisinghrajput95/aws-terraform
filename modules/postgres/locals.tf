locals {
  name = "accord-postgres"
  azs  = slice(data.aws_availability_zones.available.names, 0, 3)
  tags = {
    Name        = local.name
    Environment = var.environment
  }

  engine                       = "postgres"
  engine_version               = "16.3"
  family                       = "postgres16"
  major_engine_version         = "16"
  env_non_prod                 = ["dev", "qa", "stage"]
  env_higher                   = ["production", "stage"]
  env_prod                     = ["production"]
  instance_class_nonprod       = "db.t3.large"
  instance_class_prod          = "db.m5.large"
  instance_class               = "db.t4g.large"
  storage_type_nonprod         = "gp2"
  storage_type_prod            = "io1"
  instance_class_replica_prod  = "db.m5.large"
  instance_class_replica_stage = "db.t2.medium"
  protocol                     = "tcp"
  port                         = 5432
  allocated_storage            = 20
  max_allocated_storage        = 100
  iops                         = 5000
}