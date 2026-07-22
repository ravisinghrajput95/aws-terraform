locals {
  name                 = "cloudcart-bastion"
  vpc_cidr             = var.vpc_cidr
  azs                  = slice(data.aws_availability_zones.available.names, 0, 3)
  key_name             = "cloudcart-bastion"
  iam_instance_profile = "cloudcart-bastion-role"

  # Bootstrap the bastion with tooling for EKS and RDS/Postgres operations.
  user_data = <<-EOT
  #!/bin/bash
  set -x

  # Base packages (Amazon Linux 2)
  yum update -y
  yum install -y jq git unzip tar bash-completion

  # Ensure the SSM agent is running for Session Manager access (pre-installed on AL2)
  systemctl enable --now amazon-ssm-agent

  # psql client for RDS Postgres
  amazon-linux-extras enable postgresql14
  yum install -y postgresql

  # AWS CLI v2
  curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o awscliv2.zip
  unzip -q awscliv2.zip
  ./aws/install --update
  rm -rf aws awscliv2.zip

  # Session Manager plugin (SSM port-forwarding to RDS, etc.)
  yum install -y https://s3.amazonaws.com/session-manager-downloads/plugin/latest/linux_64bit/session-manager-plugin.rpm

  # kubectl
  curl -fsSLO "https://dl.k8s.io/release/$(curl -fsSL https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
  rm -f kubectl

  # aws-iam-authenticator
  curl -fsSLo aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.21.2/2021-07-05/bin/linux/amd64/aws-iam-authenticator
  install -o root -g root -m 0755 aws-iam-authenticator /usr/local/bin/aws-iam-authenticator
  rm -f aws-iam-authenticator

  # Helm v3
  curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

  # eksctl
  curl -fsSL "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_Linux_amd64.tar.gz" | tar xz -C /tmp
  mv /tmp/eksctl /usr/local/bin/

  # k9s (terminal UI for Kubernetes)
  curl -fsSL "https://github.com/derailed/k9s/releases/latest/download/k9s_Linux_amd64.tar.gz" | tar xz -C /tmp k9s
  mv /tmp/k9s /usr/local/bin/

  # Handy shell completion / aliases for the default user
  echo 'source <(kubectl completion bash)' >> /home/ec2-user/.bashrc
  echo 'alias k=kubectl' >> /home/ec2-user/.bashrc
  echo 'complete -o default -F __start_kubectl k' >> /home/ec2-user/.bashrc
  EOT

  tags = {
    Name = local.name
  }
}
