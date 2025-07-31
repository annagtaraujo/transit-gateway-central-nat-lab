# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "git@github.com:terraform-aws-modules/terraform-aws-ec2-instance.git?ref=v6.0.2"
}

dependency "vpc" {
  config_path = "../vpc"

#  mock_outputs = {
#    vpc_id = "fake-vpc-id"
#    private_subnets = ["a","b"]
#  }
}

inputs = {
  name = "test-instance"

  instance_type = "t2.micro"
  key_name      = "test-instance-key-tgw-us-east"
  subnet_id     = dependency.vpc.outputs.private_subnets[0]
  create_eip    = true
  
  security_group_ingress_rules = {
    ingress_allow_all = {
      cidr_ipv4   = "0.0.0.0/0"
      from_port   = 0
      ip_protocol = "-1" # SG Permissivo para teste
      to_port     = 65535
    }
  }

  tags = {
    Terraform = "true"
    Name      = "test-instance"
  }
}