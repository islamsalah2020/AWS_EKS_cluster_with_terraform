locals {
  cluster_name = "my_eks_cluster"
}

resource "aws_eip" "nat" {
  count = 3

  vpc = true
}

data "aws_availability_zones" "available" {
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.2.0"

  name                 = "eks-cluster-vpc"
  cidr                 = "10.0.0.0/16"
  azs                  = data.aws_availability_zones.available.names
  # Private subnets for worker nodes
  private_subnets      = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"] 
  # Public subnet for Internet Gateway to provide public routing
  public_subnets       = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  enable_nat_gateway   = true
  single_nat_gateway   = false
  enable_dns_hostnames = true
  # Passing the 3 IPs into the module for the 3 subnets
  reuse_nat_ips = true
  external_nat_ip_ids = "${aws_eip.nat.*.id}"
  
  tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}