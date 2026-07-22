data "terraform_remote_state" "dev" {
  backend = "s3"
  config = {
    bucket = "cloudcart-dev-terraform-state"
    key    = "dev/terraform.tfstate"
    region = "us-west-2"
  }
}

data "terraform_remote_state" "qa" {
  backend = "s3"
  config = {
    bucket = "cloudcart-terraform-backend"
    key    = "qa/terraform.tfstate"
    region = "us-west-2"
  }
}

data "terraform_remote_state" "stage" {
  backend = "s3"
  config = {
    bucket = "cloudcart-terraform-backend"
    key    = "stage/terraform.tfstate"
    region = "us-west-2"
  }
}

data "terraform_remote_state" "production" {
  backend = "s3"
  config = {
    bucket = "cloudcart-terraform-production-state"
    key    = "production/terraform.tfstate"
    region = "us-west-2"
  }
}
