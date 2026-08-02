{ ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history.share = false;

    oh-my-zsh = {
      enable = true;
      theme = ""; # starship makes the prompt
      plugins = [
        "git"
        "fzf"
        "z"
      ];
    };

    shellAliases = {
      awk = "gawk";
      ll = "eza -la";
      ls = "ls --color=auto";
      sed = "sed";
    };
  };
}
