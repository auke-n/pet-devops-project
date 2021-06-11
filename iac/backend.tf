terraform {
  backend "s3" {
    encrypt = true
    bucket  = "tf-state456723"
    region  = "eu-central-1"
    key     = "terraform.tfstate"
  }
}
