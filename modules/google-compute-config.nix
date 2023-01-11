({ pkgs, lib, config, options, specialArgs, modulesPath }: {
  imports = [ "${toString modulesPath}/virtualisation/google-compute-config.nix" ];

  services.openssh.passwordAuthentication = lib.mkForce true;
  services.openssh.permitRootLogin = lib.mkForce "yes";
})
