{ pkgs, ... }:

{
  home.packages = with pkgs; [
      bat
      black
      ruff
      eza
      fd
      fzf
      git
      gitoxide
      htop
      jq
      ripgrep
      tree
      wget

      (python3.withPackages (ps: with ps; 
        [
          numpy
          scipy
          jupyter
          jupyterlab
          ipython
          matplotlib
        ]
      ))
    ];
}
