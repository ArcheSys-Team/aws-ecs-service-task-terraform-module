variable "security_groups_ids" {
  type        = list(string)
  description = "security_groups_ids"
  default     = []
}

variable "subnet_ids" {
  type        = list(string)
  description = "subnet_ids"
  default     = []
}

variable "ecs_task_definition_family" {
  type        = string
  description = "ecs_task_definition_family"
  default     = "alb"
}

variable "ecs_launch_type" {
  type        = string
  description = "ecs_launch_type"
  default     = null
}

variable "certificate_arn" {
  type        = string
  description = "certificate_arn"
  default     = null
}

variable "container_name" {
  type        = string
  description = "container_name"
  default     = ""
}

variable "container_image" {
  type        = string
  description = "container_image"
  default     = ""
}

variable "cpu" {
  type        = number
  description = "cpu"
  default     = 256
}

variable "task_memory" {
  type        = number
  description = "memory"
  default     = 512
}

variable "task_cpu" {
  type        = number
  description = "cpu"
  default     = 256
}

variable "memory" {
  type        = number
  description = "memory"
  default     = 512
}


variable "container_port" {
  type        = number
  description = "container_port"
  default     = 80
}

variable "container_host_port" {
  type        = number
  description = "container_host_port"
  default     = 80
}

variable "container_protocol" {
  type        = string
  description = "container_protocol"
  default     = "tcp"
}

variable "ecs_service_name" {
  type        = string
  description = "ecs_service_name"
  default     = "ecs_service_name"
}

variable "container_desired_count" {
  type        = number
  description = "container_desired_count"
  default     = 2
}


variable "lb_arns" {
  type        = string
  description = "lb_arns"
  default     = ""
}

variable "network_mode" {
  type        = string
  description = "network_mode"
  default     = "awsvpc"
}


variable "launch_type" {
  type        = string
  description = "launch_type"
  default     = "EC2"
}

variable "ecs_task_execution_role_arn" {
  type        = string
  description = "ecs_task_execution_role_arn"
  default     = ""
}


variable "ecs_cluster_id" {
  type        = string
  description = "ecs_cluster_id"
  default     = ""
}

variable "force_new_deployment" {
  type        = bool
  description = "force_new_deployment"
  default     = null
}

variable "region" {
  description = "region"
  default     = "us-east-1"
}


variable "cloudwatch_log_group_name" {
  description = "cloudwatch_log_group_name"
  default     = ""
}


variable "path" {
  type        = string
  description = "path"
}

variable "permissions_boundary" {
  type        = string
  description = "permissions boundary"
}

variable "aws_iam_role_name" {
  type        = string
  description = "aws_iam_role_name"
  default     = "aws_iam_role_name"
}

variable "aws_iam_policy_name" {
  type        = string
  description = "aws_iam_policy_name"
  default     = "aws_iam_policy_name"
}


variable "ecsTaskExecutionRole_name" {
  type        = string
  description = "ecsTaskExecutionRole_name"
  default     = "ecsTaskExecutionRole1"
}

variable "cluster_type" {
  description = "The type of ECS cluster (e.g., FARGATE)"
  type        = string
}


variable "ecs_agent_name" {
  type        = string
  description = "ecs_agent_name"
  default     = "ecs-agent"
}

variable "common_tags" {
  description = "Dummy variable to silence warnings"
  type        = map(string)
  default     = {}
}


variable "target_group_name" {
  description = "Name for the target group"
  type        = string
}

variable "target_type" {
  description = "Type of target, can be 'instance' or 'ip'"
  type        = string
}

variable "protocol" {
  description = "Type of target, can be 'instance' or 'ip'"
  type        = string
}

variable "port" {
  description = "Port on which targets receive traffic"
  type        = number
}

variable "vpc_id" {
  description = "ID of the VPC in which to create the target group"
  type        = string
}

variable "health_check_path" {
  description = "The destination for the health check request"
  type        = string
  default     = "/"
}

variable "timeout" {
  description = "timeout"
  type        = string
}

variable "interval" {
  description = "interval"
  type        = string
}

variable "healthy_threshold" {
  description = "healthy_threshold"
  type        = string
}

variable "unhealthy_threshold" {
  description = "unhealthy_threshold"
  type        = string
}

variable "matcher" {
  description = "matcher"
  type        = string
}

variable "database_user" {
  type        = string
  description = "database_user"
  default     = "database_user"
}

variable "database_password" {
  type        = string
  description = "database_password"
  default     = "database_password"
}

variable "instance_endpoint" {
  type        = string
  description = "instance_endpoint"
  default     = "instance_endpoint"
}
