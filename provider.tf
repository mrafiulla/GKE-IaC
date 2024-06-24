
# https://www.terraform.io/language/settings/backends/gcs
terraform {
  backend "gcs" {
    bucket = "tf-state-rafi-staging"
    prefix = "terraform/state"
    credentials = "./creds/serviceaccount.json"
    project = "rafi-sandbox-rafi"
    region = "me-central2"
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

provider "google" {
   credentials = "${file("./creds/serviceaccount.json")}"
   project     = "rafi-sandbox-rafi" # REPLACE WITH YOUR PROJECT ID
   region      = "me-central2"
 }

