# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "git@github.com:terraform-aws-modules/terraform-aws-vpc.git?ref=v6.0.1"
}

inputs = {
  name = "vpc-origin-test"
  cidr = "10.1.0.0/16"

  azs             = ["us-west-2a", "us-west-2b", "us-west-2c"]
  private_subnets = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
  public_subnets  = ["10.1.101.0/24", "10.1.102.0/24", "10.1.103.0/24"]
  
  private_subnet_suffix = "subnet-pv"
  public_subnet_suffix  = "subnet-pb"

  enable_nat_gateway = false

  tags = {
    Terraform = "true"
    Name      = "vpc-origin-test"
  }
}