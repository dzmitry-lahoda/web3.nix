# # https://github.com/hashicorp/terraform-provider-google/issues/7696

# # gandi

# resource "google_dns_managed_zone" "the_zone" {
#   name        = "${var.PROJECT}"
#   dns_name    = "${var.PROJECT}.com."
#   description = "Decentral"
# }

{ config, lib, options, specialArgs }:
let var = options.variable;
in rec { provider = { gandi = { }; }; }
