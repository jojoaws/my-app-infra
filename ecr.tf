resource "aws_ecr_repository" "app_repo" {
  name = "my-app"
}

resource "aws_ecr_repository" "worker_repo" {
  name = "worker"
}
