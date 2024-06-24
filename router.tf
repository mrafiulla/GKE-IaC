resource "google_compute_router" "router" {
  name    = "router"
  region  = "me-central2"
  network = google_compute_network.test-vpc.id
}
