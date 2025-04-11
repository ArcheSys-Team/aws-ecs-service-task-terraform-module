output "ecs_cluster_arn" {
  value = module.ecs-cluster-fargate-module.ecs_cluster_arn
}

output "cloudwatch_log_group_name" {
  value = module.ecs-cluster-fargate-module.cloudwatch_log_group_name
}

output "kms_key_arn" {
  value = module.ecs-cluster-fargate-module.kms_key_arn
}

output "ecs_cluster_id" {
  value = module.ecs-cluster-fargate-module.ecs_cluster_id
}

output "target_group_arns" {
  value = module.alb.target_group_arns[*]
}

output "lb_arn" {
  value = module.alb.lb_arn
}

output "permissions_boundary" {
  value = module.iam.default_iam_role_permissions_boundary
}

output "subnet_ids" {
  value = module.network.subnet_ids
}

output "db_instance_username" {
  description = "The master username for the database"
  value       = module.rds-mysql.db_instance_username
  sensitive   = true
}

output "db_instance_password" {
  description = "The database password (this password may be old, because Terraform doesn't track it after initial creation)"
  value       = module.rds-mysql.db_instance_password
  sensitive   = true
}

output "db_instance_endpoint" {
  description = "The connection endpoint without port number"
  value       = replace(module.rds-mysql.db_instance_endpoint, "/:\\d+$/", "")
}

