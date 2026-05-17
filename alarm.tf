resource "aws_cloudwatch_metric_alarm" "worker_queue_alarm" {
  alarm_name = "worker-queue-scale-out"

  namespace   = "AWS/SQS"
  metric_name = "ApproximateNumberOfMessagesVisible"

  dimensions = {
    QueueName = aws_sqs_queue.worker_queue.name
  }

  statistic = "Average"
  period    = 60

  evaluation_periods = 1
  threshold          = 5

  comparison_operator = "GreaterThanThreshold"

  alarm_actions = [
    aws_appautoscaling_policy.worker_scale_up_policy.arn,
    aws_sns_topic.alerts_topic.arn
  ]
}

resource "aws_cloudwatch_metric_alarm" "worker_queue_low_alarm" {
  alarm_name = "worker-queue-scale-in"

  namespace   = "AWS/SQS"
  metric_name = "ApproximateNumberOfMessagesVisible"

  dimensions = {
    QueueName = aws_sqs_queue.worker_queue.name
  }

  statistic = "Average"
  period    = 60

  evaluation_periods = 1
  threshold          = 1

  comparison_operator = "LessThanThreshold"

  alarm_actions = [
    aws_appautoscaling_policy.worker_scale_in_policy.arn,
    aws_sns_topic.alerts_topic.arn
  ]
}
