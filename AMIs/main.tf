provider "aws" {
  region = "us-east-1"
  profile = "mskcc"
}

terraform {
  backend "s3" {
    bucket        = "mskcc-terraform-state-parallel-cluster"
    key           = "state/terraform.tfstate"
    region        = "us-east-1"
    profile       = "mskcc"
    use_lockfile  = true
  }
}

module "aws_services" {
  source = "./ec2-image-builder"
}
