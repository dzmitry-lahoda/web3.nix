# resource "google_compute_image" "default" {
#   name = "${var.PROJECT}-image"

#   raw_disk {
#     source = "../../result/nixos-image-22.11.20230101.0bf3109-x86_64-linux.raw.tar.gz"
#   }
# }




resource "google_storage_bucket_object" "gce-image" {
 name = "${var.PROJECT}-image"
  source = "../../result/nixos-image-22.11.20230101.0bf3109-x86_64-linux.raw.tar.gz"
  bucket = google_storage_bucket.gce-image.name
}