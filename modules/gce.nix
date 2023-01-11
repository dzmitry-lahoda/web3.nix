({ pkgs, lib, config, options, specialArgs, modulesPath }: {

  imports = [ "${toString modulesPath}/virtualisation/google-compute-image.nix" ];

  services.sshd.enable = true;
  services.nginx.enable = true;

  networking.firewall.allowedTCPPorts = [ 80 ];

  users.users.root.password = "nixos";
  services.openssh.permitRootLogin = lib.mkDefault "yes";
  services.getty.autologinUser = lib.mkDefault "root";

  # boot.growPartition = true;
  # boot.loader.grub.device = "/dev/sda";

  # boot.loader.grub.fsIdentifier = "provided";
  # environment.systemPackages = [ pkgs.hello ];
  # system.configurationRevision = "qwe"; # lib.mkIf (self ? rev) self.rev;
  # networking.firewall.allowedTCPPorts = [ 80 ];
  # fileSystems = {
  #   "/" = {
  #     device = "/dev/disk/by-label/nixos";
  #     autoResize = true;
  #     fsType = "ext4";
  #   };
  #   "/boot" = {
  #     device = "/dev/disk/by-label/boot";
  #     autoResize = false;
  #     fsType = "fat32";
  #   };
  # };
  # services.httpd = {
  #   adminAddr = "root@localhost";
  #   enable = true;
  # };
})
