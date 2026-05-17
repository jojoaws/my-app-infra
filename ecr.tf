resource "aws_ecr_repository" "app_repo" {
  name = "my-app"

  force_delete = true
}

resource "aws_ecr_repository" "worker_repo" {
  name = "worker"

  force_delete = true
}
