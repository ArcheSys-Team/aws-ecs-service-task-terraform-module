mock_provider "aws" {}

override_module {
  target = module.ecs-cluster-fargate-module
  outputs = {
    ecs_cluster_id            = "ecs_cluster_id"
    ecs_cluster_arn           = "ecs_cluster_arn"
    cloudwatch_log_group_name = "cloudwatch_log_group_name"
    kms_key_arn               = "kms_key_arn"
  }
}

run "Testing_ecs_cluster_id" {

  assert {
    condition     = module.ecs-cluster-fargate-module.ecs_cluster_id == "ecs_cluster_id"
    error_message = "ecs_cluster_id is not matched"
  }
}

run "Testing_ecs_cluster_arn" {

  assert {
    condition     = module.ecs-cluster-fargate-module.ecs_cluster_arn == "ecs_cluster_arn"
    error_message = "ecs_cluster_arn is not matched"
  }
}

run "Testing_cloudwatch_log_group_name" {

  assert {
    condition     = module.ecs-cluster-fargate-module.cloudwatch_log_group_name == "cloudwatch_log_group_name"
    error_message = "cloudwatch_log_group_name is not matched"
  }
}

run "Testing_kms_key_arn" {

  assert {
    condition     = module.ecs-cluster-fargate-module.kms_key_arn == "kms_key_arn"
    error_message = "kms_key_arn is not matched"
  }
}