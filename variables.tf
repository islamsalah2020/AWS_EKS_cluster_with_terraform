variable "region" {
  default     = "us-west-2"
  description = "AWS target region"
}

# variable "aws_azs" {
#   default     = "us-west-2a, us-west-2b, us-west-2c"
#   description = "AWS target AZ"
# }

variable "az_count" {
  default     = 3
  description = "count of AZ"
}

variable "map_accounts" {
  description = "Additional AWS account to add to the aws-auth configmap."
  type        = list(string)

  default = [
    "12345",
    "6789",
  ]
}

variable "map_roles" {
  description = "Additional IAM roles to add to the aws-auth configmap."
  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))

  default = [
    {
      rolearn  = "arn:aws:iam::12345:role/role1"
      username = "role1"
      groups   = ["system:masters"]
    },
  ]
}

variable "map_users" {
  description = "Additional IAM users to add to the aws-auth configmap."
  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))

  default = [
    {
      userarn  = "arn:aws:iam::12345:user/user1"
      username = "user1"
      groups   = ["system:masters"]
    },
    {
      userarn  = "arn:aws:iam::12345:user/user2"
      username = "user2"
      groups   = ["system:masters"]
    },
  ]
}