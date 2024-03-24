terraform {
  backend "s3" {
    bucket = "project-devops-1-ref"
    key    = "lastchance/terraform.tfstate"
    region = "eu-west-1"
  }
}
