terraform {
  backend "s3" {
    bucket = "petclinic-tfstates"
    key    = "backend.tfstate"
    region = "ap-south-1"
  }
}
