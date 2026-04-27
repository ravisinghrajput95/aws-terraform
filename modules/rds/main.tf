module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "${local.name}-${var.environment}" # Using environment name in the identifier

  engine                           = local.engine
  engine_version                   = local.engine_version
  instance_class                   = contains(local.env_non_prod, var.environment) ? local.instance_class_nonprod : local.instance_class_prod
  allocated_storage                = local.max_allocated_storage
  skip_final_snapshot              = true
  db_name                          = var.db_name
  username                         = var.username
  password                         = var.password
  port                             = local.port
  manage_master_user_password      = false
  final_snapshot_identifier_prefix = "${local.name}-${var.environment}"
  multi_az                         = contains(local.env_higher, var.environment) ? true : false
  create_db_subnet_group           = true
  subnet_ids                       = var.private_subnet_ids
  vpc_security_group_ids           = [module.security_group.security_group_id]

  # Separate parameter group for MySQL
  family               = local.family
  major_engine_version = local.major_engine_version
  # Encryption at rest
  storage_encrypted = true

  # Backup retention
  backup_retention_period = contains(local.env_prod, var.environment) ? 7 : 0

  # Disable automatic maintenance
  auto_minor_version_upgrade = false

  # Disk type based on environment
  storage_type = contains(local.env_non_prod, var.environment) ? local.storage_type_nonprod : local.storage_type_prod
  iops         = contains(local.env_prod, var.environment) ? 5000 : null
  tags         = local.tags
}

resource "aws_db_parameter_group" "db_parameter_group" {
  count       = contains(local.env_higher, var.environment) ? 1 : 0
  name        = "db-parameter-group-${var.environment}"
  family      = local.family
  description = "Custom parameter group for ${var.environment} environment"

  # Add more parameters as required
  parameter {
    name  = "character_set_server"
    value = "utf8"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8"
  }
}

resource "aws_db_instance" "read_replica" {
  count                  = contains(local.env_higher, var.environment) ? 1 : 0
  identifier             = "${module.db.db_instance_identifier}-read-replica"
  replicate_source_db    = module.db.db_instance_identifier
  instance_class         = contains(local.env_higher, var.environment) ? local.instance_class_replica_prod : local.instance_class_replica_stage
  allocated_storage      = local.allocated_storage
  vpc_security_group_ids = [module.security_group.security_group_id]
  depends_on             = [module.db.db_instance_identifier]
}

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = local.name
  description = "Replica MySQL example security group"
  vpc_id      = var.vpc_id

  # ingress
  ingress_with_cidr_blocks = [
    {
      from_port   = local.port
      to_port     = local.port
      protocol    = local.protocol
      description = "MySQL access from within VPC"
      cidr_blocks = var.cidr_blocks
    },
  ]

  tags = local.tags
}
