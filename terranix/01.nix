# # https://github.com/hashicorp/terraform-provider-google/issues/7696

# # gandi

# resource "google_dns_managed_zone" "the_zone" {
#   name        = "${var.PROJECT}"
#   dns_name    = "${var.PROJECT}.com."
#   description = "Decentral"
# }

{ config, lib, options, specialArgs }:
let var = options.variable;
in rec {
  variable = {
    PROJECT = {
      type = "string";
      description = "Google Cloud Project ID";
    };
    GANDI_KEY = { type = "string"; };
  };
  provider = { gandi = { key = "\${var.GANDI_KEY}"; }; };
  terraform.required_providers.gandi.source = "go-gandi/gandi";

  resource = {
    # gandi_livedns_domain = {
    #   domain = {
    #     name = "composablefi.tech";
    #   };
    # };
    gandi_domain.domain = {
      name = "composablefi.tech";
      lifecycle = { prevent_destroy = true; };

      autorenew = true;

      owner = {
        email = "dzmitry@lahoda.pro";
        city = "Funchal";
        country = "PT";
        family_name = "lahoda";
        given_name = "dzmtiry";
        phone = "+351.914069170";
        type = "person";
        zip = "9060-343";
        street_addr = "Example";
      };
      tech = {
        email = "dzmitry@lahoda.pro";
        city = "Funchal";
        country = "PT";
        family_name = "lahoda";
        given_name = "dzmtiry";
        phone = "+351.914069170";
        type = "person";
        zip = "9060-343";
        street_addr = "Example";
      };
      admin = {
        email = "dzmitry@lahoda.pro";
        city = "Funchal";
        country = "PT";
        family_name = "lahoda";
        given_name = "dzmtiry";
        phone = "+351.914069170";
        type = "person";
        zip = "9060-343";
        street_addr = "Example";
      };
      billing = {
        email = "dzmitry@lahoda.pro";
        city = "Funchal";
        country = "PT";
        family_name = "lahoda";
        given_name = "dzmtiry";
        phone = "+351.914069170";
        type = "person";
        zip = "9060-343";
        street_addr = "Example";
      };
    };
  };
}
