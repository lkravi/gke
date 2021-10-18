resource "google_compute_network" "vpc_network" {
  name = var.network
}

module "vpc" {
    source  = "terraform-google-modules/network/google//modules/subnets"
    version = "~> 3.0.0"

    project_id   = var.project_id
    network_name = var.network

    subnets = [
        {
            subnet_name           = "us-central1-01"
            subnet_ip             = var.subnet_cidr
            subnet_region         = "us-central1"
        }
    ]

    secondary_ranges = {
        us-central1-01 = [
            {
                range_name    = "us-central1-01-gke-01-pods"
                ip_cidr_range = var.pods_cidr
            },
            {
                range_name    = "us-central1-01-gke-01-services"
                ip_cidr_range = var.services_cidr
            }
        ]
    }

    depends_on = [google_compute_network.vpc_network]
}
