{ config, pkgs, ... }:

{
  home.username = "jeffreyh";
  home.homeDirectory = "/Users/jeffreyh";
  home.stateVersion = "25.05";

  # Let home-manager manage itself (installs the `home-manager` CLI)
  programs.home-manager.enable = true;

  # --- Default packages ---
  home.packages = with pkgs; [
    git
    ripgrep
    fd
    fzf
    bat
    eza
    htop
    jq
    tree
    wget
  ];

  # --- zsh + Oh My Zsh ---
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
      plugins = [ "git" "fzf" "z" ];
    };

    shellAliases = {
      ll = "eza -la";
      cat = "bat";
    };

    initContent = ''
      prompt_context() {
        if [[ "$USER" == "jeffreyh" ]]; then
          prompt_segment magenta white "%m"
        else
          prompt_segment magenta white "%n@%m"
        fi
      }
    '';
  };

  programs.git = {
    enable = true;
    settings = {
      core.editor = "nvim";
    };
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    withRuby = false;
    withPython3 = false;

    extraPackages = with pkgs; [
      pyright
      clang-tools
      nixd
    ];

    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
    ];
  
  extraLuaConfig = ''
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

      vim.lsp.config('pyright', { on_attach = on_attach })
      vim.lsp.config('clangd',  { on_attach = on_attach })
      vim.lsp.config('nixd',    { on_attach = on_attach })

      vim.lsp.enable({ 'pyright', 'clangd', 'nixd' })

      vim.diagnostic.config({ virtual_text = true, signs = true, underline = true })
    '';
  };
}
