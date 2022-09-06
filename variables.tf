variable "azs" {
  type        = list(string)
  description = "List of availability zones for subnets"
  default = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c",
    "us-east-1d"
  ]
}

variable "name" {
  type        = string
  description = "Name for the VPC and EKS cluster"
}

variable "private_cidr" {
  type        = string
  description = "Private CIDR range"
  default     = "10.0.0.0/20"
}

variable "public_cidr" {
  type        = string
  description = "Public CIDR range"
  default     = "10.0.16.0/23"
}

variable "tgw_id" {
  type        = string
  description = "Transit Gateway ID to attach VPC to"
}

variable "default_tags" {
  type        = map(string)
  description = "Default tags"
  default = {
    Environment = ""
    Service     = ""
    Owner       = "aptosone"
    Terraform   = "true"
  }
}
