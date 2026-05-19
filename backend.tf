terraform {
  backend "s3" {
    bucket         = "cloud-mastery-tfstate-bucket"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-locks"
  }
}
