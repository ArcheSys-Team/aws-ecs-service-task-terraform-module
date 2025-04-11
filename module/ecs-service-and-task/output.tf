output "ecs_task_arn" {
  value = aws_ecs_task_definition.ecs_task.arn
}

output "ecs_service_id" {
  value = aws_ecs_service.ecs_service.id
}

output "ecs_task_execution_role" {
  value = aws_iam_role.ecs_task_execution_role[*].arn
}

