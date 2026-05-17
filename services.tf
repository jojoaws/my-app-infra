resource "aws_ecs_service" "app_service" {
  name            = "my-app-service"
  cluster         = aws_ecs_cluster.main_cluster.id
  task_definition = aws_ecs_task_definition.app_task.arn

  desired_count = 2
  launch_type   = "FARGATE"

  network_configuration {
    subnets = [
      aws_subnet.private_subnet_1.id,
      aws_subnet.private_subnet_2.id
    ]
    security_groups = [
      aws_security_group.ecs_sg.id
    ]

    assign_public_ip = false
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.app_tg.arn

    container_name = "my-app"
    container_port = 3000
  }
  depends_on = [
    aws_lb_listener.http_listener
  ]
}

resource "aws_ecs_service" "worker_service" {
  name            = "worker-service"
  cluster         = aws_ecs_cluster.main_cluster.id
  task_definition = aws_ecs_task_definition.worker_task.arn

  desired_count = 1
  launch_type   = "FARGATE"

  network_configuration {
    subnets = [
      aws_subnet.private_subnet_1.id,
      aws_subnet.private_subnet_2.id
    ]
    security_groups = [
      aws_security_group.ecs_sg.id
    ]
      
    assign_public_ip = false
  }
}
