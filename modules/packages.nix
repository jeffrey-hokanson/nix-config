{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bat
    black
    coreutils
    diffutils
    eza
    fd
    findutils
    fzf
    gawk
    git
    gitoxide
    gnugrep
    gnused
    gnutar
    gnutls
    htop
    jq
    nixfmt
    ripgrep
    ruff
    tmux
    tree
    wget
    which

    (python3.withPackages (
      ps: with ps; [
        numpy
        scipy
        jupyter
        jupyterlab
        ipython
        matplotlib
        snakeviz
      ]
    ))
  ];
}
