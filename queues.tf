resource "aws_sqs_queue" "worker_dlq" {
  name = "worker-dlq"
}

resource "aws_sqs_queue" "worker_queue" {
  name = "worker-queue"

  visibility_timeout_seconds = 60

  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.worker_dlq.arn
    maxReceiveCount     = 3
  })
}
