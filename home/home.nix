{
  config,
  pkgs,
  hostname,
  inputs,
  ...
}: let
  yappachino = hostname == "yappachino";
in {
  imports = [
    inputs.nvf.homeManagerModules.default
    inputs.niri.homeModules.niri
    ./wayland
  ];
  # ++ lib.optional yappachino ../../home/wayland;

  home = {
    username = "dom";
    homeDirectory = "/home/dom";
  };

  home.packages = with pkgs;
    [
      vim
      alejandra
      nix-output-monitor
      rofi
      slurp
      wl-clipboard
      tokyo-night-gtk
      bibata-cursors
      wlr-randr
      cava
      tty-clock
      swaynotificationcenter
      pamixer
      libreoffice-qt
    ]
    ++ (with pkgs; [
      nautilus
      zenity
      gnome-tweaks
      eog
      gedit
    ]);

  programs.kitty.enable = true;

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "Dracula";
      theme_background = false;
    };
  };

  programs.pywal.enable = true;

  # Enabling Zsh with some plugins
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;
    shellAliases = {
      ll = "ls -lah";
      gs = "git status";
    };
    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.zsh-autosuggestions;
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.zsh-syntax-highlighting;
      }
      {
        name = "zsh-history-substring-search";
        src = pkgs.zsh-history-substring-search;
      }
    ];
    initExtra = ''
      eval "$(starship init zsh)"
    '';
  };

  # Enabling git
  programs.git = {
    enable = true;
    userName = "dvach167";
    userEmail = "dvach167@mtroyal.ca";
  };

  # Starship! Bash Shell
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  # I think we know
  programs.vscode.enable = true;

  # Notification Manager
  services.mako.enable = true;

  # Make sure that Home Manager is ENABLED!
  programs.home-manager.enable = true;

  # More cursor fixing, this is such a pain omg
  home.pointerCursor = let
    getFrom = url: hash: name: {
      gtk.enable = true;
      x11.enable = true;
      name = "BreezeX";
      size = 24;
      package = pkgs.runCommand "moveUp" {} ''
        mkdir -p $out/share/icons
        ln -s ${pkgs.fetchzip {
          url = url;
          hash = hash;
        }} $out/share/icons/${name}
      '';
    };
  in
    getFrom
    "https://github.com/ful1e5/BreezeX_Cursor/releases/download/v2.0.1/BreezeX-Black.tar.xz"
    "sha256-uRmCyFVpVN+47r9HXErxZQjheGdLPcGJTwc+mDvF9Os="
    "BreezeX";

  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "gsettings set org.gnome.desktop.interface cursor-theme' '${config.home.pointerCursor.name}'"
      "settings set org.gnome.desktop.interface cursor-size ${toString config.home.pointerCursor.size}"
    ];
  };

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk]; # Fixes OpenURI and cursor themes in flatpaks
    config = {
      hyprland.preferred = ["hyprland" "gtk"];
    };
  };

  gtk = {
    enable = true;
    cursorTheme = {
      name = "BreezeX";
      package = pkgs.kdePackages.breeze-gtk;
    };
  };

  home.stateVersion = "23.11";
}
