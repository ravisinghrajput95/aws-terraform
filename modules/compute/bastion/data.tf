data "aws_availability_zones" "available" {}

# Latest self-owned bastion AMI baked by Packer (packer/). Only queried when no
# explicit ami_id is supplied.
data "aws_ami" "bastion" {
  count       = var.ami_id == "" ? 1 : 0
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "name"
    values = ["cloudcart-bastion-*"]
  }
}
