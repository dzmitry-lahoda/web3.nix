({ pkgs, lib, config, options, specialArgs, modulesPath }: {

  imports =
    [ "${toString modulesPath}/virtualisation/google-compute-image.nix" ];
  virtualisation.googleComputeImage.configFile =
    builtins.toFile "configuration.nix"
    (builtins.readFile ./google-compute-config.nix);
  # educational purposes only
  services.openssh.passwordAuthentication = lib.mkForce true;
  users.users.root.password = "root";
  services.openssh.permitRootLogin = lib.mkForce "yes";
})
