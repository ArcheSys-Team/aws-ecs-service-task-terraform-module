mock_provider "aws" {}

override_module {
  target = module.ecs-cluster-fargate-module
  outputs = {
    ecs_cluster_arn = "ecs_cluster_arn"
  }
}

run "Testing_ecs_cluster_arn" {

  assert {
    condition     = module.ecs-cluster-fargate-module.ecs_cluster_arn == "ecs_cluster_arn"
    error_message = "ecs_cluster_arn is not matched"
  }
}