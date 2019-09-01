// Configure GCP
provider "google" {
 credentials = "${file("keys/credentials-gcp-compute.json")}"
 project = "${var.project_name}"
 region = "${var.region}"
 zone = "${var.region_zone}"
}
