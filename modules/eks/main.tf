module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.31"

  # Networking - These come from the VPC outputs you just created
  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids

  # Cluster Access
  cluster_endpoint_public_access = true
  
  # This makes YOUR current AWS user the cluster admin automatically (New in v20)
  enable_cluster_creator_admin_permissions = true

  # Managed Node Group (The actual servers)
  eks_managed_node_groups = {
    general = {
      instance_types = ["t3.medium"]
      min_size     = 1
      max_size     = 2
      desired_size = 1
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}