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
    gnupg
    gnused
    gnutar
    gnutls
    htop
    jq
    mpv
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
        yt-dlp
      ]
    ))
  ];
}
