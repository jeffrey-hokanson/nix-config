{ ... }:

{
  programs.nixvim = {
    # Supplies the default per-server configs (cmd, filetypes, root markers)
    plugins.lspconfig.enable = true;

    lsp = {
      servers = {
        # Advertise blink.cmp's completion capabilities to every server
        "*".config.capabilities.__raw = "require('blink.cmp').get_lsp_capabilities()";

        basedpyright.enable = true;
        jsonls.enable = true;
        marksman.enable = true;
        nixd.enable = true;
        texlab.enable = true;

        clangd = {
          enable = true;
          config.filetypes = [
            "c"
            "cpp"
            "cu"
            "h"
            "hpp"
            "ipp"
            "proto"
            "cuh"
          ];
        };
      };

      # Buffer-local keymaps, set when a server attaches
      keymaps =
        let
          lspBuf = key: lspBufAction: {
            mode = "n";
            inherit key lspBufAction;
            options.silent = true;
          };
          lua = key: fn: {
            mode = "n";
            inherit key;
            action.__raw = fn;
            options.silent = true;
          };
        in
        [
          (lspBuf "gd" "definition")
          (lspBuf "gr" "references")
          (lspBuf "K" "hover")
          (lspBuf "<leader>rn" "rename")
          (lspBuf "<leader>ca" "code_action")
          (lua "<leader>f" "function() vim.lsp.buf.format({ async = true }) end")
          (lua "[d" "function() vim.diagnostic.jump({ count = -1 }) end")
          (lua "]d" "function() vim.diagnostic.jump({ count = 1 }) end")
        ];
    };
  };
}
