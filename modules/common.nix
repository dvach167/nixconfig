{
  config,
  pkgs,
  ...
}: {
  # Set your system state version (update this when you upgrade NixOS)
  system.stateVersion = "24.11";

  # Example of a common configuration (adjust as needed)
  time.timeZone = "America/Edmonton";

  # Timezone and shii
  i18n.defaultLocale = "en_CA.UTF-8";
}
