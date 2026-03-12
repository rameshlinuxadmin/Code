include "root" {
  path   = find_in_parent_folders("root.hcl") # Explicitly find root.hcl
  expose = true
}

terraform {
  source = "../../../modules/vpc"
}

inputs = {
  vpc_name        = "learning-vpc"
  vpc_cidr        = "10.0.0.0/16"
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.10.0/24", "10.0.11.0/24"]
}