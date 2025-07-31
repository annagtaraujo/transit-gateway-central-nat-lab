# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders("root.hcl")
}

dependency "us_east_tgw-peering" {
  config_path = "../tgw-peering-attachment"

#  mock_outputs = {
#    peer_transit_gateway_id = "fake-vpc-id"
#  }
}

dependency "us_east_tgw" {
  config_path = "../tgw"

#  mock_outputs = {
#    ec2_transit_gateway_id = "fake-vpc-id"
#  }
}

terraform {
  source = "git::git@github.com:plus3it/terraform-aws-tardigrade-transit-gateway//modules/route"
}

inputs = {
  transit_gateway_attachment_id       = dependency.us_east_tgw-peering.outputs.peering_attachment.id
  transit_gateway_route_table_id      = dependency.us_east_tgw.outputs.ec2_transit_gateway_route_table_id

  destination_cidr_block = "10.1.0.0/16"
}
