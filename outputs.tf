output "alb_dns_name" {
  value = aws_lb.app_alb.dns_name
}

output "worker_queue_url" {
  value = aws_sqs_queue.worker_queue.url
}

output "app_ecr_repo_url" {
  value = aws_ecr_repository.app_repo.repository_url
}

output "worker_ecr_repo_url" {
  value = aws_ecr_repository.worker_repo.repository_url
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.main_cluster.name
}
