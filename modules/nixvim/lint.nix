{ pkgs, ... }:

{
  programs.nixvim = {
    extraPackages = [ pkgs.buf ];

    # nvim-lint, for linters that aren't full LSP servers
    plugins.lint = {
      enable = true;
      lintersByFt.proto = [ "buf_lint" ];
      autoCmd = {
        event = [
          "BufWritePost"
          "BufEnter"
          "InsertLeave"
        ];
        pattern = "*.proto";
      };
    };
  };
}
