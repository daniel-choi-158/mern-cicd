// Configure GCP
provider "google" {
 credentials = "${file("keys/credentials-gcp-compute.json")}"
 project = "practice-space-250608"
 region = "us-central1"
 zone = "us-central1-a"
}
