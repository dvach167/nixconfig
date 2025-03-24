{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../../modules/common.nix
    ../../modules/services.nix
    ../../modules/users.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "yapperchino";

  # Enable experimental features (flakes and nix-command)
  nix.settings.experimental-features = ["nix-command" "flakes"];

  programs.zsh.enable = true;

  # Enable Framework Kernel Updates
  services.fwupd.enable = true;

  # Enable fingerprint reader support
  services.fprintd.enable = true;

  # System packages for this host
  environment.systemPackages = with pkgs; [
    vscode
    obsidian
    fuzzel
    fastfetch
    discord-canary
    p7zip
    btop
    nextcloud-client
    kde-rounded-corners
    ghostty
  ];

  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;

  services.desktopManager.plasma6.enable = true;

  boot.loader = {
    systemd-boot.enable = false;
    efi.efiSysMountPoint = "/boot";
    grub = {
      enable = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
      device = "nodev";
    };
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };
  programs.firefox.enable = true;

  # Create the laptop user with sudo (wheel) privileges
  users.users.dom = {
    isNormalUser = true;
    home = "/home/dom";
    extraGroups = ["wheel" "networkmanager" "docker"];
    shell = pkgs.zsh;
  };
}
