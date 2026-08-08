{ programs, ... }:

{
  programs.tmux = {
    enable = true;
    prefix = "C-a";

    extraConfig = ''
      unbind C-b
      bind C-a send-prefix
    '';
  };
}
