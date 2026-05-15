resource "aws_ecs_task_definition" "app_task" {
  family                   = "my-app-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  cpu    = "256"
  memory = "512"

  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name  = "my-app"
      image = "${aws_ecr_repository.app_repo.repository_url}:latest"

      essential = true

      environment = [
        {
          name  = "QUEUE_URL"
          value = aws_sqs_queue.worker_queue.url
        },
        {
          name  = "AWS_REGION"
          value = var.aws_region
        }
      ]

      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"

        options = {
          awslogs-group         = aws_cloudwatch_log_group.app_logs.name
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}

resource "aws_ecs_task_definition" "worker_task" {
  family                   = "worker-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  cpu    = "256"
  memory = "512"

  execution_role_arn = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name  = "worker"
      image = "${aws_ecr_repository.worker_repo.repository_url}:latest"

      essential = true

      environment = [
        {
          name  = "QUEUE_URL"
          value = aws_sqs_queue.worker_queue.url
        },
        {
          name  = "AWS_REGION"
          value = var.aws_region
        }
      ]

      logConfiguration = {
        logDriver = "awslogs"

        options = {
          awslogs-group         = aws_cloudwatch_log_group.worker_logs.name
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}
