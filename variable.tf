variable "aws_region" {
  description = "The AWS region where resources will be created."
  type        = string
  default     = "us-east-1"
}

variable "cluster_name" {
  description = "The name of the ECS cluster."
  type        = string
  default     = "medusa-newcluster"
}

variable "role_name" {
  description = "The name of the IAM role for ECS task execution."
  type        = string
  default     = "medusa-execution--newrole"
}

variable "task_family" {
  description = "The name of the ECS task definition family."
  type        = string
  default     = "medusa-newtask"
}

variable "task_cpu" {
  description = "The CPU units for the ECS task."
  type        = number
  default     = 256
}

variable "task_memory" {
  description = "The memory for the ECS task in MiB."
  type        = number
  default     = 512
}

variable "container_image" {
  description = "The Docker image for the ECS container."
  type        = string
  default     = "node:latest"
}

variable "container_cpu" {
  description = "The CPU units for the ECS container."
  type        = number
  default     = 256
}

variable "container_memory" {
  description = "The memory for the ECS container in MiB."
  type        = number
  default     = 512
}


variable "container_port" {
  description = "The port on which the container listens."
  type        = number
  default     = 3000
}

variable "host_port" {
  description = "The port on the host for the container port mapping."
  type        = number
  default     = 3000
}

variable "service_name" {
  description = "The name of the ECS service."
  type        = string
  default     = "medusa-service"
}

variable "desired_count" {
  description = "The desired number of ECS tasks for the service."
  type        = number
  default     = 1
}

variable "subnets" {
  description = "The subnets where ECS tasks will be launched."
  type        = list(string)
  default     = ["subnet-019fe497b362ff64f"]
}

variable "security_groups" {
  description = "The security groups for the ECS tasks."
  type        = list(string)
  default     = ["sg-0081ae07ba0cbaa9a"]
}

variable "assign_public_ip" {
  description = "Whether to assign a public IP to ECS tasks."
  type        = bool
  default     = false
}
