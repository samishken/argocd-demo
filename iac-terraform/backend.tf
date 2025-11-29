terraform {
  backend "s3" {
    bucket  = "terraform-state-dev-samboo"
    key     = "argocd-demo/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
