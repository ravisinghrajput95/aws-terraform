#!/bin/bash
# Bakes EKS + RDS/Postgres tooling into the CloudCart bastion AMI.
# Runs at BUILD time (with internet), so the running instance needs no egress.
set -euxo pipefail

# Base packages
yum update -y
yum install -y jq git unzip tar bash-completion

# SSM agent is pre-installed on Amazon Linux 2; make sure it starts on boot
systemctl enable amazon-ssm-agent

# psql client for RDS Postgres
amazon-linux-extras enable postgresql14
yum install -y postgresql

# AWS CLI v2
curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o awscliv2.zip
unzip -q awscliv2.zip
./aws/install --update
rm -rf aws awscliv2.zip

# Session Manager plugin
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

# Shell completion / aliases for the default user, baked into the image
cat >> /home/ec2-user/.bashrc <<'BASHRC'
source <(kubectl completion bash)
alias k=kubectl
complete -o default -F __start_kubectl k
BASHRC
