# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "git@github.com:terraform-aws-modules/terraform-aws-vpc.git?ref=v6.0.1"
}

inputs = {
  name = "vpc-nat-center-test"
  cidr = "10.2.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.2.1.0/24", "10.2.2.0/24", "10.2.3.0/24"]
  public_subnets  = ["10.2.101.0/24", "10.2.102.0/24", "10.2.103.0/24"]

  enable_nat_gateway = true

  tags = {
    Terraform = "true"
    Name      = "vpc-nat-center-test"
  }
}