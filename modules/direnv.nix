{ ... }:

{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true; # faster, flake-aware caching backend
    enableZshIntegration = true;
  };
}
