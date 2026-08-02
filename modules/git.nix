{ ... }:

{
  programs.git = {
    enable = true;
    settings = {
      core.editor = "nvim";
    };
  };
}
