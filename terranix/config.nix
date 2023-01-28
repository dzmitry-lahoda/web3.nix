{ config, lib, options, specialArgs }:
let var = options.variable;
in rec {
  variable.PROJECT = {
    type = "string";
    description = "Google Cloud Project ID";
  };

  resource = {
    local_file.test_import = {
      filename = "test_import.txt";
      content = "Hello";
    };
    google_service_account = {
      default = {
        account_id = "\${ var.PROJECT }-account";
        project = "\${ var.PROJECT }";
      };
    };

    time_sleep = {
      google_service_account-default = {
        depends_on = [ "resource.google_service_account.default" ];
        create_duration = "30s";
      };
    };

    google_compute_address = { static = { name = "ipv4-address"; }; };

    google_storage_bucket = {
      gce-image = {
        name = "\${var.PROJECT}-gce-image";
        location = "US";
        force_destroy = true;
      };
    };

#     resource "google_compute_image" "gce-image" {
#   name = "gce-image"

#   raw_disk {
#     source = google_storage_bucket_object.gce-image-gz.self_link
#   }
# }


# resource "google_storage_bucket_object" "gce-image-gz" {
#  name = "${var.PROJECT}-image.tar.gz"
#   source = "../../result/nixos-image-22.11.20230101.0bf3109-x86_64-linux.raw.tar.gz"
#   bucket = google_storage_bucket.gce-image.name
# }

  };

  provider = {
    google = {
      region = "us-central1";
      zone = "us-central1-c";
      project = "\${ var.PROJECT }";
    };
  };
}
