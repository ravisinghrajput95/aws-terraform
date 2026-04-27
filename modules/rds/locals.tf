locals {
  name   = "accord-mysql"
  azs    = slice(data.aws_availability_zones.available.names, 0, 3)
  region = "us-west-2"
  tags = {
    Name    = local.name
    Example = local.name
  }

  engine                       = "mysql"
  engine_version               = "8.0"
  family                       = "mysql8.0" # DB parameter group
  major_engine_version         = "8.0"      # DB option group
  instance_class               = "db.t4g.large"
  allocated_storage            = 20
  max_allocated_storage        = 100
  port                         = 3306
  iops                         = 5000
  instance_class_nonprod       = "db.t3.large"
  instance_class_prod          = "db.m5.large"
  storage_type_nonprod         = "gp2"
  storage_type_prod            = "io1"
  env_non_prod                 = ["dev", "qa", "stage"]
  env_higher                   = ["production", "stage"]
  env_prod                     = ["production"]
  instance_class_replica_prod  = "db.m5.large"
  instance_class_replica_stage = "db.t2.medium"
  protocol                     = "tcp"
}
