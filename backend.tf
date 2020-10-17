terraform {
  backend "s3" {
    bucket = "bunjow-versioning"
    key    = "terraform/my_tfstate"
    region = "us-east-1"
  }
}
