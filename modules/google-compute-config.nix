({ pkgs, lib, config, options, specialArgs, modulesPath }: {
  imports = [ "${toString modulesPath}/virtualisation/google-compute-config.nix" ];

  # educational purposes only
  services.openssh.passwordAuthentication = mkDefault true;
  users.users.root.password = "root";
  services.openssh.permitRootLogin = lib.mkDefault "yes";
  services.getty.autologinUser = lib.mkDefault "root";
})
