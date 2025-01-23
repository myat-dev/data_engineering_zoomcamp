terraform {
    required_providers {
        google = {
            source = "hashicorp/google"
            version = "4.51.0"
        }
    }
}

provider "google" {

    credentials = "01-docker-terraform/1_terraform/service_account_key.json"
    project = "terra-demo-19290"
    region  = "asia-northeast1"
}

resource "google_storage_bucket" "data-lake-bucket" {
  name          = "terra-demo-19290-my-bucket"
  location      = "asia"

  # Optional, but recommended settings:
  storage_class = "STANDARD"
  uniform_bucket_level_access = true

  versioning {
    enabled     = true
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }
    condition {
      age = 3
    }
  }

  force_destroy = true
}


resource "google_bigquery_dataset" "dataset" {
  dataset_id = "terra-demo-dataset"
  project    = "terra-demo-19290-demo-dataset"
  location   = "asia"
}