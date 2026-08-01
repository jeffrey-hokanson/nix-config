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
      theme = "";  # starship makes the prompt
      plugins = [ "git" "fzf" "z" ];
    };

    shellAliases = {
      ll = "eza -la";
      cat = "bat";
    };
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
  
  initLua = ''
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

  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      format = "$hostname$directory$git_branch$git_status$git_metrics$character";

      hostname = {
        ssh_only = false;
        format = "[ $hostname ](bg:purple fg:white)";
        disabled = false;
      };

      directory = {
        format = "[ $path ]($style)";
        style = "fg:blue bg:white";
        truncation_length = 0;
        truncate_to_repo = false;
      };

      git_branch = {
        format = "[ $symbol$branch(:$remote_branch) ]($style)";
        symbol = "  ";
        style = "fg:#030B1 bg:#7DF9AA";
      };

      git_status = {
        format = "[$all_status]($style)";
        style = "fg:#030B16 bg:#7DF9AA";
      };

      git_metrics = {
        format = "([+$added]($added_style))[]($added_style)";
        added_style = "fg:#1C3A5E bg:#FCF392";
        deleted_style = "fg:bright-red bg:235";
        disabled = false;
      };

      hg_branch = {
        format = "[ $symbol$branch ]($style)";
        symbol = " ";
      };

      cmd_duration = {
        format = "[  $duration ]($style)";
        style = "fg:bright-white bg:18";
      };

      character = {
        success_symbol = "[ ➜](bold green) ";
        error_symbol = "[ ✗](#E84D44) ";
      };

      time = {
        disabled = true;
      };
    };
  };
}
