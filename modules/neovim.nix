{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    withRuby = false;
    withPython3 = false;

    extraPackages = with pkgs; [
      buf
      clang-tools
      marksman
      nixd
      pyright
      texlab
    ];

    plugins = with pkgs.vimPlugins; [
      blink-cmp
      edge
      friendly-snippets
      gitsigns-nvim
      nord-nvim
      nvim-lint
      nvim-lspconfig
    ];

    initLua = ''
      vim.opt.termguicolors = true
      vim.g.edge_style = 'default'
      vim.g.edge_better_performance = 1
      vim.cmd.colorscheme('edge')
      vim.opt.tabstop = 2
      vim.opt.expandtab = true
      vim.opt.shiftwidth = 2
      vim.opt.number = true -- line numbering

      local on_attach = function(_, bufnr)
         local opts = { buffer = bufnr, noremap = true, silent = true }
         vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
         vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
         vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
         vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
         vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
         vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format({ async = true }) end, opts)
         vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
         vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
       end

       require('gitsigns').setup({
         signs = {
           add          = { text = '+' },
           change       = { text = '~' },
           delete       = { text = '-' },
           topdelete    = { text = '‾' },
           changedelete = { text = '~' },
         },
         on_attach = function(bufnr)
           local gs = package.loaded.gitsigns
           local opts = { buffer = bufnr, noremap = true, silent = true }
           vim.keymap.set('n', ']c', gs.next_hunk, opts)
           vim.keymap.set('n', '[c', gs.prev_hunk, opts)
           vim.keymap.set('n', '<leader>hp', gs.preview_hunk, opts)
           vim.keymap.set('n', '<leader>hs', gs.stage_hunk, opts)
           vim.keymap.set('n', '<leader>hr', gs.reset_hunk, opts)
         end,
       })

       vim.filetype.add({
        extension = {
          h   = 'cpp',
          hpp = 'cpp',
          cu  = 'cpp',
          cuh = 'cpp',
          cpp = 'cpp',
          ipp = 'ipp',
        },
       })

       -- Completion (blink.cmp)
       -- LaTeX (texlab) and Markdown (marksman) completions, such as references,
       -- citations, and links, arrive through the 'lsp' source, and
       -- friendly-snippets adds snippets for both filetypes.
       require('blink.cmp').setup({
         keymap = { preset = 'default' },
         completion = {
           documentation = { auto_show = true, auto_show_delay_ms = 200 },
         },
         sources = {
           default = { 'lsp', 'path', 'snippets', 'buffer' },
         },
       })

       -- Advertise blink's completion capabilities to every LSP server
       vim.lsp.config('*', {
         capabilities = require('blink.cmp').get_lsp_capabilities(),
       })

       -- LSP setup
       vim.lsp.config('clangd', { 
          on_attach = on_attach,
          filetypes = { 'c', 'cpp', 'cu', 'h', 'hpp', 'ipp', 'proto', 'cuh' },
       })
       vim.lsp.config('marksman', { on_attach = on_attach })
       vim.lsp.config('nixd',     { on_attach = on_attach })
       vim.lsp.config('pyright',  { on_attach = on_attach })
       vim.lsp.config('texlab',   { on_attach = on_attach })
       vim.lsp.enable({ 'pyright', 'clangd', 'nixd', 'texlab', 'marksman' })

       -- nvim-lint setup (for linters that aren't full LSP servers)
       local lint = require('lint')
       lint.linters_by_ft = {
         proto = { 'buf_lint' },
       }

       -- Run the linter on save and when entering/reading a buffer
       vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufEnter', 'InsertLeave' }, {
         pattern = '*.proto',
         callback = function()
           lint.try_lint()
         end,
       })

       vim.diagnostic.config({ virtual_text = true, signs = true, underline = true })

    '';
  };
}
