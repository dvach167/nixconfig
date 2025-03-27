{pkgs, ...}: {
  fonts.packages = with pkgs; [
    departure-mono
    fira-code
    fira-code-symbols
    work-sans
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    texlivePackages.alfaslabone
  ];
}
