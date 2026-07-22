module "postgres" {
  source     = "terraform-aws-modules/rds/aws"
  version    = "~> 5.0"
  identifier = "${local.name}-${var.environment}"

  engine               = local.engine
  engine_version       = local.engine_version
  family               = local.family
  major_engine_version = local.major_engine_version
  instance_class       = contains(local.env_non_prod, var.environment) ? local.instance_class_nonprod : local.instance_class_prod

  allocated_storage     = local.allocated_storage
  max_allocated_storage = local.max_allocated_storage

  db_name                          = var.db_name
  username                         = var.username
  password                         = var.password
  port                             = local.port
  multi_az                         = contains(local.env_higher, var.environment) ? true : false
  skip_final_snapshot              = false
  final_snapshot_identifier_prefix = "${local.name}-${var.environment}"
  create_db_subnet_group           = true
  subnet_ids                       = var.private_subnet_ids
  vpc_security_group_ids           = [module.security_group.security_group_id]
  deletion_protection              = false

  # Encryption at rest
  storage_encrypted = true

  # Backup retention
  backup_retention_period = contains(local.env_prod, var.environment) ? 7 : 0

  # Disable automatic maintenance
  auto_minor_version_upgrade = false

  # Disk type based on environment
  storage_type = contains(local.env_non_prod, var.environment) ? local.storage_type_nonprod : local.storage_type_prod
  iops         = contains(local.env_prod, var.environment) ? 5000 : null

  # Add more parameters as required
  parameters = [
    {
      name  = "autovacuum"
      value = 1
    },
    {
      name  = "client_encoding"
      value = "utf8"
    }
  ]
  tags = local.tags
  db_option_group_tags = {
    "Sensitive" = "low"
  }
  db_parameter_group_tags = {
    "Sensitive" = "low"
  }

}

resource "aws_db_instance" "read_replica" {
  count                  = contains(local.env_higher, var.environment) ? 1 : 0
  identifier             = "${module.postgres.db_instance_id}-read-replica"
  replicate_source_db    = module.postgres.db_instance_id
  instance_class         = contains(local.env_higher, var.environment) ? local.instance_class_replica_prod : local.instance_class_replica_stage
  allocated_storage      = local.allocated_storage
  vpc_security_group_ids = [module.security_group.security_group_id]
  depends_on             = [module.postgres.db_instance_id]
}

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = local.name
  description = "SG for Postgres RDS instance"
  vpc_id      = var.vpc_id

  # ingress: from within the VPC, plus (optionally) the shared bastion VPC
  ingress_with_cidr_blocks = concat(
    [
      {
        from_port   = local.port
        to_port     = local.port
        protocol    = local.protocol
        description = "Postgres RDS access from within VPC"
        cidr_blocks = var.cidr_blocks
      },
    ],
    var.bastion_cidr != "" ? [
      {
        from_port   = local.port
        to_port     = local.port
        protocol    = local.protocol
        description = "Postgres RDS access from shared bastion VPC"
        cidr_blocks = var.bastion_cidr
      },
    ] : []
  )

  tags = local.tags
}

