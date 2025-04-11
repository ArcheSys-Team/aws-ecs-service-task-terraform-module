data "terraform_remote_state" "alb-and-ecs-cluster-backend" {
  backend = "s3"
  config = {
    bucket = "oc-terraform-pocs-backend-bucket-123456789"
    key    = "oc-terraform-aws-ecs-bucket/albll-and-ecs-cluster-backend.tfstate"
    region = "us-east-1"
  }
}


data "terraform_remote_state" "ecs-cluster-task-and-service" {
  backend = "s3"
  config = {
    bucket = "oc-terraform-pocs-backend-bucket-123456789"
    key    = "oc-terraform-aws-ecs-bucket/ecsll-cluster-task-and-service.tfstate"
    region = "us-east-1"
  }
}


data "terraform_remote_state" "rds-mysql" {
  backend = "s3"
  config = {
    bucket = "oc-terraform-pocs-backend-bucket-123456789"
    key    = "oc-terraform-aws-ecs-bucket/rdsll-mysql.tfstate"
    region = "us-east-1"
  }
}


