#provider "google" {
#  project = "ingka-cybersec-gkesec-test"
#  region  = "us-central1"
#  zone    = "us-central1-c"
#}

resource "google_storage_bucket" "bucket_vuln" {
  name = "terraform-rw-poc-bucket-vuln"
  ######################
  # Misconfiguration 1
  # * Versioning not enabled
  ##########################
  #versioning {
  #  enabled = true
  #}
}

resource "google_storage_bucket_access_control" "public_rule_vuln" {
  bucket = "terraform-rw-poc-bucket-vuln"
  #twistcli wants name as string value
  #bucket = "google_storage_bucket.bucket.name"
  ######################
  # Misconfiguration 2
  # * allUsers = Public read access on the bucket
  ######################
  role   = "READER"
  entity = "allUsers"
  #entity = "serviceAccount"
}

resource "google_sql_database_instance" "master_vuln" {
  name             = "master-instance"
  database_version = "POSTGRES_11"
  region           = "us-central1"

  settings {
    # Second-generation instance tiers are based on the machine
    # type. See argument reference below.
    tier = "db-f1-micro"
  }
}

  ######################
  # Misconfiguration 3
  # * No SSL certificate configured for the database
  ######################
#resource "google_sql_ssl_cert" "client_cert" {
#  common_name = "client-name"
#  instance    = "master-instance"
#  #twistcli wants name as string value
#  #instance    = google_sql_database_instance.master.name
#}
