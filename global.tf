variable "name" {
  description = "The ECS cluster name this will launching instances for."
  type        = string
  default = "demo-auto"
}
variable "clustername" {
  description = "The ECS cluster name "
  type        = string
  default = "demo-auto"
}

variable "environment" {
  description = "Environment tag."
  type        = string
  default = "test"
}

variable "image_id" {
  description = "Amazon ECS-Optimized AMI."
  type        = string
  default = "ami-0c6120f461d6b39e9"
}

variable "instance_type" {
  description = "The instance type to use."
  type        = string
  default     = "t2.micro"
}

variable "vpc_id" {
  description = "The id of the VPC to launch resources in."
      default = "vpc-0cbe206f3c2671a16"
}

variable "subnet1" {
   description = "A list of subnet IDs to launch resources in."
  # type        = list(string)
  default      = "subnet-0f3aeacbb4c9982a2"

}
variable "subnet2" {
  description = "A list of subnet IDs to launch resources in."
  # type       = list(string)
  default     = "subnet-09be467e5dbb254bc"


}

variable "use_AmazonEC2ContainerServiceforEC2Role_policy" {
   description = "Attaches the AWS managed AmazonEC2ContainerServiceforEC2Role policy to the ECS instance role."
   type        = string
   default     = true
 }

