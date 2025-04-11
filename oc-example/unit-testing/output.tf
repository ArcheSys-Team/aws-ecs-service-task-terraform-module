output "ecs_cluster_id" {
  value = module.ecs-cluster-fargate-module.ecs_cluster_id
}

output "ecs_cluster_arn" {
  value = module.ecs-cluster-fargate-module.ecs_cluster_arn
}

output "cloudwatch_log_group_name" {
  value = module.ecs-cluster-fargate-module.cloudwatch_log_group_name
}

output "kms_key_arn" {
  value = module.ecs-cluster-fargate-module.kms_key_arn
}