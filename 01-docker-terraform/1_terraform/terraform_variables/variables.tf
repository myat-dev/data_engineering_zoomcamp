variable "credentials" {
  description = "My Credentials"
  default     = "01-docker-terraform/1_terraform/service_account_key.json"
  #ex: if you have a directory where this file is called keys with your service account json file
  #saved there as my-creds.json you could use default = "./keys/my-creds.json"
}


variable "project" {
  description = "Project"
  default     = "terra-demo-19290"
}

variable "region" {
  description = "Region"
  #Update the below to your desired region
  default     = "asia-northeast1"
}

variable "location" {
  description = "Project Location"
  #Update the below to your desired location
  default     = "asia"
}

variable "bq_dataset_name" {
  description = "My BigQuery Dataset Name"
  #Update the below to what you want your dataset to be called
  default     = "terra-demo-dataset"
}

variable "gcs_bucket_name" {
  description = "My Storage Bucket Name"
  #Update the below to a unique bucket name
  default     = "terra-demo-19290-my-bucket"
}

variable "gcs_storage_class" {
  description = "Bucket Storage Class"
  default     = "STANDARD"
}