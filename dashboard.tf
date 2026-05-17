resource "aws_cloudwatch_dashboard" "main_dashboard" {
  dashboard_name = "cloud-mastery-dashboard"

  dashboard_body = jsonencode({
    widgets = [

      {
        type   = "metric"
        width  = 12
        height = 6

        properties = {
          title = "SQS Queue Depth"

          metrics = [
            [
              "AWS/SQS",
              "ApproximateNumberOfMessagesVisible",
              "QueueName",
              aws_sqs_queue.worker_queue.name
            ]
          ]

          period = 60
          stat   = "Average"
          region = var.aws_region
        }
      },

      {
        type   = "metric"
        width  = 12
        height = 6

        properties = {
          title = "Worker ECS CPU"

          metrics = [
            [
              "AWS/ECS",
              "CPUUtilization",
              "ClusterName",
              aws_ecs_cluster.main_cluster.name,
              "ServiceName",
              aws_ecs_service.worker_service.name
            ]
          ]

          period = 60
          stat   = "Average"
          region = var.aws_region
        }
      },

      {
        type   = "metric"
        width  = 12
        height = 6

        properties = {
          title = "App ECS CPU"

          metrics = [
            [
              "AWS/ECS",
              "CPUUtilization",
              "ClusterName",
              aws_ecs_cluster.main_cluster.name,
              "ServiceName",
              aws_ecs_service.app_service.name
            ]
          ]

          period = 60
          stat   = "Average"
          region = var.aws_region
        }
      },

      {
        type   = "metric"
        width  = 12
        height = 6

        properties = {
          title = "Worker Running Tasks"

          metrics = [
            [
              "ECS/ContainerInsights",
              "RunningTaskCount",
              "ClusterName",
              aws_ecs_cluster.main_cluster.name,
              "ServiceName",
              aws_ecs_service.worker_service.name
            ]
          ]

          period = 60
          stat   = "Average"
          region = var.aws_region
        }
      },

      {
        type   = "metric"
        width  = 12
        height = 6

        properties = {
          title = "ALB Request Count"

          metrics = [
            [
              "AWS/ApplicationELB",
              "RequestCount",
              "LoadBalancer",
              aws_lb.app_alb.arn_suffix
            ]
          ]

          period = 60
          stat   = "Sum"
          region = var.aws_region
        }
      },

      {
        type   = "metric"
        width  = 12
        height = 6

        properties = {
          title = "ALB Unhealthy Hosts"

          metrics = [
            [
              "AWS/ApplicationELB",
              "UnHealthyHostCount",
              "TargetGroup",
              aws_lb_target_group.app_tg.arn_suffix,
              "LoadBalancer",
              aws_lb.app_alb.arn_suffix
            ]
          ]

          period = 60
          stat   = "Average"
          region = var.aws_region
        }
      }
    ]
  })
}
