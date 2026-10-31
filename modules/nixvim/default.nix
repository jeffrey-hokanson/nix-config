{ pkgs, ... }:

{
  imports = [
    ./completion.nix
    ./gitsigns.nix
    ./lint.nix
    ./lsp.nix
  ];

  programs.nixvim = {
    enable = true;
    nixpkgs.useGlobalPackages = true;
    defaultEditor = true;
    withRuby = false;
    withPython3 = false;

    opts = {
      termguicolors = true;
      number = true; # line numbering
      tabstop = 2;
      shiftwidth = 2;
      expandtab = true;
    };

    # nixvim has no module for the edge colorscheme, so load it as a plain plugin.
    extraPlugins = [ pkgs.vimPlugins.edge ];
    globals = {
      mapleader = " ";
      maplocalleader = " ";
      edge_style = "default";
      edge_better_performance = 1;
    };
    colorscheme = "edge";

    filetype.extension = {
      h = "cpp";
      hpp = "cpp";
      cu = "cpp";
      cuh = "cpp";
      cpp = "cpp";
      ipp = "ipp";
    };

    diagnostic.settings = {
      virtual_text = true;
      signs = true;
      underline = true;
    };
  };
}
