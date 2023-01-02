({ pkgs, lib, config, options, specialArgs, modulesPath }: {
  #imports = [ "${toString modulesPath}/virtualisation/virtualbox-image.nix" ];
  imports = [ "${toString modulesPath}/installer/virtualbox-demo.nix" ];

  # boot.isContainer = false;
  # #boot.loader.systemd-boot.enable = true;
  # boot.loader.grub.fsIdentifier = "provided";
  environment.systemPackages = [ pkgs.hello ];
  # #system.configurationRevision = lib.mkIf (self ? rev) self.rev;
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
