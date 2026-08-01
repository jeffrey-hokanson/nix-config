{ config, pkgs, ... }:

{
  home.username = "jeffreyh";
  home.homeDirectory = "/Users/jeffreyh";
  home.stateVersion = "25.05";

  # Let home-manager manage itself (installs the `home-manager` CLI)
  programs.home-manager.enable = true;

  # --- Default packages ---
  home.packages = with pkgs; [
    git
    ripgrep
    fd
    fzf
    bat
    eza
    htop
    jq
    tree
    neovim
    wget
  ];

  # --- zsh + Oh My Zsh ---
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell"; # swap for any built-in OMZ theme name
      plugins = [ "git" "fzf" "z" ];
    };

    shellAliases = {
      ll = "eza -la";
      cat = "bat";
    };
  };
}
