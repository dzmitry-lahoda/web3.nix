{ self, withSystem, ... }: {
  flake = {
    asd = withSystem "x86_64-linux"
      ({ config, self', inputs', pkgs, devnetTools, ... }:
        let
          service-account-credential-key-file-input = builtins.fromJSON
            (builtins.readFile
              (builtins.getEnv "GOOGLE_APPLICATION_CREDENTIALS"));

          gce-to-nix = { project_id, client_email, private_key, ... }: {
            project = project_id;
            serviceAccount = client_email;
            accessKey = private_key;
          };
          gce-input = gce-to-nix service-account-credential-key-file-input;
        in {
          default = let nixpkgs = self.inputs.nixpkgs;
          in import ./.nix/devnet.nix {
            inherit nixpkgs;
            inherit gce-input;
            devnet-dali = pkgs.callPackage devnetTools.mk-devnet {
              inherit (self'.packages)
                polkadot-launch composable-node polkadot-node;
              chain-spec = "dali-dev";
            };
            devnet-picasso = pkgs.callPackage devnetTools.mk-devnet {
              inherit (self'.packages)
                polkadot-launch composable-node polkadot-node;
              chain-spec = "picasso-dev";
            };
            docs = self'.packages.docs-static;
            rev = builtins.getEnv "DEPLOY_REVISION";
          };
        });
  };
}


# { self, inputs', ... }:
# let
#   image-base =
#     builtins.trace (builtins.attrNames inputs'.nixos-generators.nixosGenerate)
#     inputs'.nixos-generators.nixosGenerate {
#       modules = [

#       ];
#       format = "gce";
#     };
# in {
#   perSystem = { config, self', inputs', pkgs, system, ... }: {
#     packages = rec {
#       composable-image-gce = image-base;
#     };
#   };
# }
