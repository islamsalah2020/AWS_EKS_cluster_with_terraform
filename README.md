# Create_EKS_cluster_with_terraform

This repo for creating and configuring the AWS EKS cluster using Terraform
  

## Prerequisite
- #### AWS account
	- Create aws user with admin priviliges to be able to create the aws resourses that we will need to implement our eks cluster.

- #### Install the following tools
	- [AWS cli](https://aws.amazon.com/cli/)
	- [Terraform](https://www.terraform.io/downloads.html)
	- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
	
	
## Steps

- After installing the AWS CLI, configure it by running `aws configure`.
```
$ aws configure
AWS Access Key ID [None]: YOUR_AWS_ACCESS_KEY_ID
AWS Secret Access Key [None]: YOUR_AWS_SECRET_ACCESS_KEY
Default region name [None]: YOUR_AWS_REGION
Default output format [None]: json
```

- Create Terraform workspace ~/eks_cluster then cd to it.
	- Create `provider.tf` for AWS provider.
	- Create `variables.tf` for all need variables.
	- Create `vpc.tf` to create and provision VPC, Private and Public subnets.
	- Create `security-groups.tf` to provision the security groups used by the EKS cluster.
	- Create `eks-cluster.tf` to provision all the resources required to set up an EKS cluster using the AWS EKS Module.
	- Create `output.tf` defines the output configuration, for creating kubeconfig to use it for deployment to kube cluster.


	
## Deployment


```
cd ~/eks_cluster

terraform init

terraform plan
terraform apply

```	


## Resources
- [AWS Terraform module](https://registry.terraform.io/providers/hashicorp/aws/latest)
- [Provision an EKS Cluster with Terraform](https://learn.hashicorp.com/tutorials/terraform/eks)
- [AWS EKS Resources](https://registry.terraform.io/providers/hashicorp/aws/3.58.0/docs/resources/eks_cluster)
