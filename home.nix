{pkgs, ... }:

{
  home.username = "jeffreyh";
  home.homeDirectory = "/Users/jeffreyh";
  home.stateVersion = "25.05";

  # Let home-manager manage itself (installs the `home-manager` CLI)
  programs.home-manager.enable = true;

  # --- Default packages ---
  home.packages = with pkgs; [
    bat
    eza
    fd
    fzf
    git
    gitoxide
    htop
    jq
    ripgrep
    tree
    wget
  ];

  # --- zsh + Oh My Zsh ---
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history.share = false;

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
      gitsigns-nvim
      nord-nvim
      edge
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


        -- LSP setup
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
      format = "$hostname[](fg:purple bg:blue)$directory[](fg:blue bg:green)$git_branch$git_metrics[ ](fg:yellow)";

      hostname = {
        ssh_only = false;
        format = "[ $hostname ](bold bg:purple fg:white)";
        disabled = false;
      };

      directory = {
        format = "[ $path ]($style)";
        style = "fg:black bg:blue";
        truncation_length = 0;
        truncate_to_repo = false;
      };

      git_status = {
        style = "fg:black bg:yellow";
	format = "[$all_status$ahead_behind]($style)";
      };

      git_branch = {
        format = "[ $symbol $branch ]($style)";
	symbol = "";
        style = "fg:white bg:green";
      };

      git_metrics = {
        format = "([](fg:green bg:yellow)[+$added]($added_style))([-$deleted]($deleted_style))";
        # format = "([+$added]($added_style))[]($added_style)";
        added_style = "bold fg:black bg:yellow";
        deleted_style = "bold fg:red bg:yellow";
        disabled = false;
      };

      character = {
        success_symbol = "[ ](fg:yellow bg:green)[](fg:green)";
        error_symbol = "[ ](fg:yellow bg:red)[](fg:red)";
      };

      time = {
        disabled = true;
      };
    };
  };
}
