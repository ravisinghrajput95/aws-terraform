module "bastion" {
  source                      = "terraform-aws-modules/ec2-instance/aws"
  version                     = "~> 5.0"
  name                        = local.name
  ami                         = data.aws_ami.amazon_linux.image_id
  instance_type               = "t3.large"
  availability_zone           = element(local.azs, 0)
  subnet_id                   = element(var.public_subnet_ids, 0)
  vpc_security_group_ids      = [var.security_group_id]
  associate_public_ip_address = true
  disable_api_stop            = false
  key_name                    = local.key_name
  create_iam_instance_profile = false
  iam_instance_profile        = var.iam_role_name
  user_data_base64            = base64encode(local.user_data)
  user_data_replace_on_change = false
  enable_volume_tags          = false
  root_block_device = [
    {
      encrypted   = true
      volume_type = "gp3"
      throughput  = 200
      volume_size = 50
      tags = {
        Name = "bastion-root-block"
      }
    },
  ]

  tags = local.tags
}

resource "aws_eip" "bastion" {
  domain     = "vpc"
  instance   = module.bastion.id
  depends_on = [module.bastion]
}
