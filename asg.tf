resource "aws_appautoscaling_target" "worker_scaling_target" {
  max_capacity = 5
  min_capacity = 1

  resource_id = "service/${aws_ecs_cluster.main_cluster.name}/${aws_ecs_service.worker_service.name}"

  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "worker_scale_up_policy" {
  name = "worker-scale-up-policy"

  policy_type = "StepScaling"

  resource_id        = aws_appautoscaling_target.worker_scaling_target.resource_id
  scalable_dimension = aws_appautoscaling_target.worker_scaling_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.worker_scaling_target.service_namespace

  step_scaling_policy_configuration {
    adjustment_type = "ChangeInCapacity"

    cooldown = 60

    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_lower_bound = 0
      metric_interval_upper_bound = 15

      scaling_adjustment = 1
    }

    step_adjustment {
      metric_interval_lower_bound = 15
      metric_interval_upper_bound = 45

      scaling_adjustment = 2
    }

    step_adjustment {
      metric_interval_lower_bound = 45

      scaling_adjustment = 5
    }
  }
}

resource "aws_appautoscaling_policy" "worker_scale_in_policy" {
  name = "worker-scale-in-policy"

  policy_type = "StepScaling"

  resource_id        = aws_appautoscaling_target.worker_scaling_target.resource_id
  scalable_dimension = aws_appautoscaling_target.worker_scaling_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.worker_scaling_target.service_namespace

  step_scaling_policy_configuration {

    adjustment_type = "ChangeInCapacity"

    cooldown = 300

    metric_aggregation_type = "Average"

    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = -1
    }
  }
}
