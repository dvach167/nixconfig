{
  config,
  pkgs,
  ...
}: {
  home.username = "dom";
  home.homeDirectory = "/home/dom";

  home.packages = [
    pkgs.vim
    pkgs.alejandra
    


    # Add other packages you want to install
  ];

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

  programs.vscode.enable = true;
  # Enable other programs and configurations as needed

  #Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.stateVersion = "23.11";
}
