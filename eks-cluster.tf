terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.56.0"
    }
  }
}
module "eks" {
  source                          = "terraform-aws-modules/eks/aws"
  cluster_name                    = local.cluster_name
  cluster_version                 = "1.20"
  subnets                         = module.vpc.private_subnets
  cluster_endpoint_private_access = true

  vpc_id = module.vpc.vpc_id


  worker_groups = [
    {
      name                          = "worker-group-1"
      instance_type                 = "t2.micro"
      additional_userdata           = "echo foo bar"
      asg_desired_capacity          = 2
      asg_max_size                  = 5
      asg_min_size                  = 1
      additional_security_group_ids = [aws_security_group.worker_group_mgmt_one.id]
    },
  ]

  worker_additional_security_group_ids = [aws_security_group.all_worker_mgmt.id]
  map_roles                            = var.map_roles
  map_users                            = var.map_users
  map_accounts                         = var.map_accounts
}

# declared endpoint and token for the deploy on k8s cluster
data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}
