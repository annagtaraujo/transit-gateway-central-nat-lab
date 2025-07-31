# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders("root.hcl")
}

dependency "us_east_tgw_peer" {
  config_path = "../../../us-east-1/dev/tgw-peering-attachment"

#  mock_outputs = {
#    peer_transit_gateway_id = "fake-vpc-id"
#  }
}

dependency "us_west_tgw" {
  config_path = "../../../us-west-2/dev/tgw"

#  mock_outputs = {
#    peer_transit_gateway_id = "fake-vpc-id"
#  }
}

terraform {
  source = "git::git@github.com:plus3it/terraform-aws-tardigrade-transit-gateway//modules/peering-accepter"
}

inputs = {
  peering_attachment_id = dependency.us_east_tgw_peer.outputs.peering_attachment.id

  transit_gateway_route_table_association = {
    transit_gateway_route_table_id = dependency.us_west_tgw.outputs.ec2_transit_gateway_route_table_id
  }
}