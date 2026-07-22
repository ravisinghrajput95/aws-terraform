packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1.3"
    }
  }
}

variable "region" {
  type    = string
  default = "us-west-2"
}

variable "instance_type" {
  type    = string
  default = "t3.medium"
}

# Optional explicit version label; defaults to a build timestamp.
variable "ami_version" {
  type    = string
  default = ""
}

# Optional build subnet. Empty uses the account's default VPC. The build
# instance needs internet egress to download tooling.
variable "subnet_id" {
  type    = string
  default = ""
}

locals {
  ami_name = "cloudcart-bastion-${var.ami_version != "" ? var.ami_version : formatdate("YYYYMMDD-hhmmss", timestamp())}"
}

# Build FROM the official Amazon Linux 2 base image (owner: amazon), looked up
# fresh at build time — we bake our own image rather than trust a prebuilt one.
source "amazon-ebs" "bastion" {
  region        = var.region
  instance_type = var.instance_type
  ssh_username  = "ec2-user"
  ami_name      = local.ami_name
  subnet_id     = var.subnet_id != "" ? var.subnet_id : null

  source_ami_filter {
    filters = {
      name                = "amzn2-ami-hvm-*-x86_64-gp2"
      virtualization-type = "hvm"
      root-device-type    = "ebs"
    }
    owners      = ["amazon"]
    most_recent = true
  }

  tags = {
    Name        = local.ami_name
    Application = "cloudcart"
    Role        = "bastion"
    BaseAMI     = "{{ .SourceAMI }}"
    BaseAMIName = "{{ .SourceAMIName }}"
    BuildDate   = "{{ isotime }}"
  }
}

build {
  name    = "cloudcart-bastion"
  sources = ["source.amazon-ebs.bastion"]

  provisioner "shell" {
    script          = "${path.root}/scripts/bootstrap.sh"
    execute_command = "sudo -E bash '{{ .Path }}'"
  }
}
