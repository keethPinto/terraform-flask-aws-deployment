terraform {
  backend "s3" {
    bucket = "keeth-s3-demo-xyz"
    key    = "keeth/terraform.tfstate"
    region = "us-east-1"
  }
}