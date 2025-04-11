resource "random_string" "random_name" {
  length  = 5
  special = false
  upper   = false
  lower   = true
}

resource "aws_lb_target_group" "my_target_group" {
  name        = var.target_group_name
  port        = var.port
  protocol    = var.protocol
  vpc_id      = var.vpc_id
  target_type = var.target_type

  health_check {
    path                = var.health_check_path
    protocol            = var.protocol
    timeout             = var.timeout
    interval            = var.interval
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
    matcher             = var.matcher
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = var.lb_arns
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_target_group.arn
  }
}

resource "aws_lb_listener" "target-group-listener_secure" {
  load_balancer_arn = var.lb_arns
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS13-1-2-Res-2021-06"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_target_group.arn
  }

  tags = var.common_tags
}


resource "aws_iam_role" "ecs_task_execution_role" {
  count                = var.cluster_type == "FARGATE" ? 1 : 0
  name                 = "${var.aws_iam_role_name}-${random_string.random_name.result}"
  path                 = var.path
  permissions_boundary = var.permissions_boundary
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
  tags = var.common_tags
}

resource "aws_iam_policy" "ecs_task_execution_policy" {
  name        = "${var.aws_iam_policy_name}-${random_string.random_name.result}"
  description = "IAM policy for ECS task execution"
  path        = var.path

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect   = "Allow",
      Action   = ["ecr:GetAuthorizationToken", "ecr:*", "logs:*", "ssm:*"],
      Resource = "*"
    }]
  })
  tags = var.common_tags
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_attachment" {
  count      = var.cluster_type == "FARGATE" ? 1 : 0
  role       = aws_iam_role.ecs_task_execution_role[count.index].name
  policy_arn = aws_iam_policy.ecs_task_execution_policy.arn
}

data "aws_iam_policy" "ecsTaskExecutionRolePolicy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
data "aws_iam_policy_document" "ecsExecutionRolePolicy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }

}

resource "aws_ecs_task_definition" "ecs_task" {
  family             = "${var.ecs_task_definition_family}-${random_string.random_name.result}"
  network_mode       = var.network_mode
  cpu                = var.task_cpu
  execution_role_arn = aws_iam_role.ecs_task_execution_role[0].arn

  requires_compatibilities = [var.ecs_launch_type] #null for ec2
  memory                   = var.task_memory


  container_definitions = jsonencode([
    {
      name                   = var.container_name
      image                  = var.container_image
      cpu                    = var.cpu
      memory                 = var.memory
      essential              = true
      readonlyRootFilesystem = true
      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = var.container_host_port
          protocol      = var.container_protocol
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-region        = var.region
          awslogs-stream-prefix = "ecs"
          awslogs-group         = var.cloudwatch_log_group_name
        }
      }
      environment = [
        {
          name  = "DATABASE_USER"
          value = var.database_user
        },
        {
          name  = "DATABASE_PASSWORD"
          value = var.database_password
        },
        {
          name  = "DATABASE_HOST"
          value = var.instance_endpoint
        },
      ]
    }
  ])
  tags = var.common_tags
}

resource "aws_ecs_service" "ecs_service" {
  name                 = "${var.ecs_service_name}-${random_string.random_name.result}"
  cluster              = var.ecs_cluster_id
  task_definition      = aws_ecs_task_definition.ecs_task.arn
  desired_count        = var.container_desired_count
  launch_type          = var.launch_type          # null for fargate 
  force_new_deployment = var.force_new_deployment #null for fargate 
  tags                 = var.common_tags

  load_balancer {
    target_group_arn = aws_lb_target_group.my_target_group.arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = var.security_groups_ids
    assign_public_ip = false
  }
}


data "aws_iam_policy_document" "ecs_agent" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}
