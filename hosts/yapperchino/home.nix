{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    inputs.nvf.homeManagerModules.default
    ./nvf
  ];

  home.username = "dom";
  home.homeDirectory = "/home/dom";

  home.packages = with pkgs; [
    vim
    alejandra
    libreoffice-qt
    # Add other packages you want to install
  ];

  programs.kitty.enable = true;
  wayland.windowManager.hyprland.enable = true;
  home.sessionVariables.NIXOS_OZONE_WL = "1";

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "Dracula";
      theme_background = false;
    };
  };

  programs.bash.enable = true;
  programs.git = {
    enable = true;
    userName = "dvach167";
    userEmail = "dvach167@mtroyal.ca";
  };

  # Starship! Bash Shell
  programs.starship.enable = true;

  # I think we know
  programs.vscode.enable = true;

  # Notification Manager
  programs.mako.enable = true;

  # Make sure that Home Manager is ENABLED!
  programs.home-manager.enable = true;

  home.stateVersion = "23.11";
}
