{
  description = "A very basic flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, nixos-generators, ... }: 
  let pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in 
  {

    packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;

    packages.x86_64-linux.virtualbox = nixos-generators.nixosGenerate {
      system = "x86_64-linux";

      modules = [
        ./modules/virtualbox.nix
        #"${toString modulesPath}/installer/virtualbox-demo.nix" 
      ];

      format = "virtualbox";
    };

    packages.x86_64-linux.gce = nixos-generators.nixosGenerate {
      system = "x86_64-linux";

      modules = [
        ./modules/gce.nix
      ];

      format = "gce";
    };

    packages.x86_64-linux.default = self.packages.x86_64-linux.hello;

    # shell with nixos-container
    nixosConfgurations.myhost = pkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./modules/virtualbox.nix ];
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
