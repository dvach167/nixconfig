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

  # Enable Framework Kernel Updates
  services.fwupd.enable = true;

  # Enable fingerprint reader support
  services.fprintd = {
    enable = true;
    tod.driver = pkgs.libfprint-2-tod1-vfs0090;
  };

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
    kdePackages.breeze-gtk
  ];

  services.xserver = {
    enable = true;
  };
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

  # All my programs that need configuring
  programs.zsh.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };

  programs.firefox.enable = true;

  # Enabling hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Create the laptop user with sudo (wheel) privileges
  users.users.dom = {
    isNormalUser = true;
    home = "/home/dom";
    extraGroups = ["wheel" "networkmanager" "docker" "input"];
    shell = pkgs.zsh;
  };
}
