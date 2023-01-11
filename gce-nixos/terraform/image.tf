resource "google_compute_image" "gce-image" {
  name = "gce-image"

  raw_disk {
    source = google_storage_bucket_object.gce-image-gz.self_link
  }
}


resource "google_storage_bucket_object" "gce-image-gz" {
 name = "${var.PROJECT}-image.tar.gz"
  source = "../../result/nixos-image-22.11.20230101.0bf3109-x86_64-linux.raw.tar.gz"
  bucket = google_storage_bucket.gce-image.name
}