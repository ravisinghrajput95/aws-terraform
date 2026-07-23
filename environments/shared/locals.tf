locals {
  name = "cloudcart-shared"

  # One entry per environment (spoke). Networking + cluster details are read
  # from each environment's remote state; spokes never read the shared state,
  # which keeps the dependency one-directional.
  spokes = {
    dev = {
      vpc_id       = data.terraform_remote_state.dev.outputs.vpc_id
      cidr         = data.terraform_remote_state.dev.outputs.vpc_cidr_block
      cluster_name = data.terraform_remote_state.dev.outputs.cluster_name
      route_table_ids = concat(
        data.terraform_remote_state.dev.outputs.private_route_table_ids,
        data.terraform_remote_state.dev.outputs.public_route_table_ids,
      )
    }
    qa = {
      vpc_id       = data.terraform_remote_state.qa.outputs.vpc_id
      cidr         = data.terraform_remote_state.qa.outputs.vpc_cidr_block
      cluster_name = data.terraform_remote_state.qa.outputs.cluster_name
      route_table_ids = concat(
        data.terraform_remote_state.qa.outputs.private_route_table_ids,
        data.terraform_remote_state.qa.outputs.public_route_table_ids,
      )
    }
    stage = {
      vpc_id       = data.terraform_remote_state.stage.outputs.vpc_id
      cidr         = data.terraform_remote_state.stage.outputs.vpc_cidr_block
      cluster_name = data.terraform_remote_state.stage.outputs.cluster_name
      route_table_ids = concat(
        data.terraform_remote_state.stage.outputs.private_route_table_ids,
        data.terraform_remote_state.stage.outputs.public_route_table_ids,
      )
    }
    production = {
      vpc_id       = data.terraform_remote_state.production.outputs.vpc_id
      cidr         = data.terraform_remote_state.production.outputs.vpc_cidr_block
      cluster_name = data.terraform_remote_state.production.outputs.cluster_name
      route_table_ids = concat(
        data.terraform_remote_state.production.outputs.private_route_table_ids,
        data.terraform_remote_state.production.outputs.public_route_table_ids,
      )
    }
  }
}
