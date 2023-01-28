{
  description = "A very basic flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    flake-utils.url = "github:numtide/flake-utils";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    terranix = {
      url = "github:terranix/terranix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, nixos-generators, terranix, flake-utils }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      system = "x86_64-linux";
      terrafromConfiguration = terranix.lib.terranixConfiguration {
        inherit system;
        modules = [ ./terranix/config.nix ];

      };

    in rec {

      packages.x86_64-linux = {

        tfconfig = terrafromConfiguration;

        hello = nixpkgs.legacyPackages.x86_64-linux.hello;

        virtualbox = nixos-generators.nixosGenerate {
          system = "x86_64-linux";

          modules = [
            ./modules/virtualbox.nix
            #"${toString modulesPath}/installer/virtualbox-demo.nix" 
          ];

          format = "virtualbox";
        };

        gce = nixos-generators.nixosGenerate {
          system = "x86_64-linux";

          modules = [ ./modules/gce.nix ];

          format = "gce";
        };

        apply = pkgs.writeShellScriptBin "apply" ''
            export TF_VAR_PROJECT=composablefi
            cd terraform/layers/05
            if [[ -e config.tf.json ]]; then rm -f config.tf.json; fi
            cp ${self.packages.${system}.tfconfig} config.tf.json \
              && ${pkgs.terraform}/bin/terraform init \
              && ${pkgs.terraform}/bin/terraform apply -auto-approve
        '';
        default = self.packages.x86_64-linux.hello;
      };

      # shell with nixos-container
      nixosConfgurations.myhost = pkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./modules/virtualbox.nix ];
      };

      apps.${system} = {
        apply = self.inputs.flake-utils.lib.mkApp {
          drv = self.packages.${system}.apply;
        };
      };

      devShell.x86_64-linux = pkgs.mkShell {
        buildInputs = with pkgs; [
          nixos-generators.packages.x86_64-linux.nixos-generate
          hello
          direnv
          nix-direnv
          awscli2
          google-cloud-sdk
          terraform
          terranix.defaultPackage.${system}
          self.packages.${system}.tfconfig
        ];
        shellHook = ''
          (
            cd gce-nixos/terraform/
            terraform init --upgrade
          )
        '';
      };

      # hook to run `complete -C aws_completer aws`

      crazy = "yes";
    };
}
