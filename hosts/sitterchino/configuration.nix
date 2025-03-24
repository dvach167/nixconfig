{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../modules/common.nix
    ../modules/services.nix
    ../modules/users.nix
  ];

  networking.hostName = "sitterchino";

  # Enable experimental features (flakes and nix-command)
  experimental-features = "nix-command flakes";

  # AMD desktop optimizations: load the amdgpu kernel module
  boot.kernelModules = ["amdgpu"];
  services.xserver.videoDrivers = ["amdgpu"];

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      amdvlk
      # Other packages if needed
    ];
  };
  environment.systemPackages = with pkgs; [
    discord-canary
    firefox
    p7zip
    btop
    steam
    nextcloud-client
    kde-rounded-corners
    ghossty
  ];

  # Create the desktop user with sudo (wheel) privileges
  users.users.sitterchino = {
    isNormalUser = true;
    extraGroups = ["wheel"];
    shell = pkgs.zsh;
  };
}
