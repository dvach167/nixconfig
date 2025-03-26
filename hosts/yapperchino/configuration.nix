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
    ../../modules/fonts.nix
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
    swww
    playerctl
    pamixer
    cava
    rofi
    bluez
  ];

  services.xserver = {
    enable = true;
  };
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

  services.blueman.enable = true;
  # Enable Bluetooth service
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      Policy.AutoEnable = true;
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
  #programs.hyprland = {
  # enable = true;
  # xwayland.enable = true;
  #};

  # Enable Niri
  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };

  # Enable Greeter
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --remember-session --asterisks --theme border=green;text=white;prompt=green;time=green;action=purple;button=green;container=black;input=white";
        user = "greeter";
      };
    };
  };

  # Enable Power Profile for Laptop
  services.power-profiles-daemon.enable = false;

  services.tlp = {
    enable = true;
    settings = {
      TLP_DEFAULT_MODE = "BAT";

      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "power";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 90;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 75;
    };
  };

  # Create the laptop user with sudo (wheel) privileges
  users.users.dom = {
    isNormalUser = true;
    home = "/home/dom";
    extraGroups = ["wheel" "networkmanager" "docker" "input"];
    shell = pkgs.zsh;
  };
}
