{
  description = "A very basic flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, nixos-generators, ... }: {

    packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;

    packages.x86_64-linux.virtualbox = nixos-generators.nixosGenerate {
      system = "x86_64-linux";
    
      modules = [
        ./modules/default.nix        
      ];
      format = "virtualbox";
    };
    packages.x86_64-linux.default = self.packages.x86_64-linux.hello;
    
    # shell with nixos-container
    nixosConfgurations.myhost = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./modules/default.nix
      ];
    };
  };
}
