locals {
  # Automatically load account-level variables
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))

  # Extract the ID for easy use
  account_id = local.account_vars.locals.aws_account_id
}

# Generate AWS provider dynamically for all sub-folders
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region = "us-east-1"

}
EOF
}

# Configure S3 backend using the account ID for a unique bucket name
remote_state {
  backend = "s3"
  config = {
    bucket         = "my-eks-state-${local.account_id}"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}