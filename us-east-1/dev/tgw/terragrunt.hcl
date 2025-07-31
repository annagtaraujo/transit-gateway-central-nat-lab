# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders("root.hcl")
}

dependency "vpc" {
  config_path = "../vpc"

#  mock_outputs = {
#    vpc_id = "fake-vpc-id"
#    private_subnets = ["a","b"]
#  }
}

terraform {
  source  = "git@github.com:terraform-aws-modules/terraform-aws-transit-gateway.git?ref=v2.13.0"
}

inputs = {
  name        = "transit-gateway-test"
  description = "My TGW shared with several other AWS Regions"

  enable_auto_accept_shared_attachments = true
  
  enable_default_route_table_association = false
  enable_default_route_table_propagation = false

  transit_gateway_default_route_table_association = false
  transit_gateway_default_route_table_propagation = false
  
  share_tgw = false

  vpc_attachments = {
    vpc = {
      vpc_id       = dependency.vpc.outputs.vpc_id
      subnet_ids   = dependency.vpc.outputs.private_subnets
      dns_support  = true
      ipv6_support = false
      
      transit_gateway_default_route_table_association = false
      transit_gateway_default_route_table_propagation = false
      
      tgw_routes = [
        {
          destination_cidr_block = "10.3.0.0/16" # Rota de teste para criar a route table
        }
      ]
    }
  }
}