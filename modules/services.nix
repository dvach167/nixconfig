{
  config,
  pkgs,
  ...
}: {
  # Enable unfree packages globally
  nixpkgs.config.allowUnfree = true;

  # Enable Pipewire for audio (and disable PulseAudio)
  hardware.pulseaudio.enable = false;
  services.pipewire.enable = true;
  services.pipewire.alsa.enable = true;

  # Enable Bluetooth service
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      Policy.AutoEnable = true;
    };
  };

  # Network
  networking = {
    networkmanager = {
      enable = true;
      wifi.powersave = false;
      wifi.scanRandMacAddress = false;
    };
    firewall.enable = true;
  };

  # OpenVPN for MRU
  services.openvpn.servers = {
    mruDBVPN = {
      config = ''config /home/dom/.config/openvpn/mruDBVPN'';
      autoStart = false;
    };
  };
}
