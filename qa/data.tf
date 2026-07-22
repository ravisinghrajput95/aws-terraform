data "terraform_remote_state" "dev" {
  backend = "s3"
  config = {
    bucket = "cloudcart-dev-terraform-state"
    key    = "dev/terraform.tfstate"
    region = "us-west-2"
  }
}
