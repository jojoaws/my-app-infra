resource "aws_ecs_cluster" "main_cluster" {
  name = "my-app-cluster"
}

resource "aws_cloudwatch_log_group" "app_logs" {
  name              = "/ecs/my-app"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_group" "worker_logs" {
  name              = "/ecs/my-worker"
  retention_in_days = 7
}
