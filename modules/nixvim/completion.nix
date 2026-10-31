{ ... }:

{
  programs.nixvim.plugins = {
    # Snippet library picked up by blink.cmp's snippets source
    friendly-snippets.enable = true;

    blink-cmp = {
      enable = true;
      settings = {
        keymap.preset = "super-tab";

        completion.documentation = {
          auto_show = true;
          auto_show_delay_ms = 200;
        };

        sources = {
          default = [
            "lsp"
            "path"
            "snippets"
            "buffer"
          ];

          # Prose: no word-matching from the buffer and no snippets. texlab and
          # marksman still complete references, citations and links via "lsp".
          per_filetype = {
            markdown = [
              "lsp"
              "path"
            ];
            tex = [
              "lsp"
              "path"
            ];
            plaintex = [
              "lsp"
              "path"
            ];
            gitcommit = [ ];
            text = [ ];
          };
        };
      };
    };
  };
}
