provider "google" {
 credentials = file("/Users/ravirygt/.ssh/gcp-terraform-sa.jason")
 project     = var.project_id
 region      = var.region
}
