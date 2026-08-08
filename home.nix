{ config, pkgs, lib, ... }:

{
  imports = [
    ./modules/packages.nix
    ./modules/git.nix
    ./modules/neovim.nix
    ./modules/starship.nix
    ./modules/latex.nix
    ./modules/zsh.nix
    ./modules/tmux.nix
  ];

  home.username = "jeffreyh";
  home.homeDirectory = "/Users/jeffreyh";
  home.stateVersion = "25.05";

  # Let home-manager manage itself (installs the `home-manager` CLI)
  programs.home-manager.enable = true;

}
