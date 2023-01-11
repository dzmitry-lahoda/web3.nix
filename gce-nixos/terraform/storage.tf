resource "google_storage_bucket" "gce-image" {
  name          = "${var.PROJECT}-gce-image"
  location      = "US"
  force_destroy = true
}
