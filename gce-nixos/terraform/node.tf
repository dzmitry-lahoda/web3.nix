resource "google_compute_instance" "node" {
  name         = var.NODE_NAME
  machine_type = "n2-standard-2"

  project = var.PROJECT
  depends_on = [
    time_sleep.google_service_account-default
  ]
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  metadata = {
    enable-oslogin = true
  }

  scratch_disk {
    interface = "SCSI"
  }

  network_interface {
    network = "default"
  }

  service_account {
    email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}
