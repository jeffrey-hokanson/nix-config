{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bat
    black
    eza
    fd
    fzf
    git
    gitoxide
    htop
    jq
    nixfmt
    ripgrep
    ruff
    tmux
    tree
    wget

    (python3.withPackages (
      ps: with ps; [
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
