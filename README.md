# How to update

1. edit home.nix
2. `home-manager switch --flake ~/nix-config 
3. commit

# Preferred Font

LiberationMono Nerd Font Mono

# Neovim

Neovim is configured declaratively with [nixvim](https://github.com/nix-community/nixvim).
The config lives in `modules/nixvim/`, one file per concern:

| File | Contents |
|---|---|
| `default.nix` | Editor options, `edge` colorscheme, filetype mappings, diagnostics |
| `completion.nix` | blink.cmp and friendly-snippets |
| `lsp.nix` | Language servers and LSP keymaps |
| `gitsigns.nix` | Git signs and hunk keymaps |
| `lint.nix` | nvim-lint (`buf` for `.proto` files) |

Nothing is written to `~/.config/nvim`; nixvim generates the config. To change
something, edit the module, run `home-manager switch --flake ~/nix-config`, and
restart Neovim. If something misbehaves, start with `:messages` and `:checkhealth`.

The leader key is Space.

## Completion

The menu appears as you type in code files.

| Key | Action |
|---|---|
| `<C-y>` | Accept the selected item (the first is preselected) |
| `<C-n>` / `<C-p>` | Next / previous item |
| `<C-space>` | Open the menu, or toggle the docs window |
| `<C-e>` | Close the menu |
| `<C-b>` / `<C-f>` | Scroll the docs window |
| `<Tab>` / `<S-Tab>` | Jump between snippet placeholders |

- Snippets: type a snippet name (e.g. `for`, `def`), accept it, then `<Tab>` through the fields.
- Prose files (Markdown, LaTeX) only offer LSP and path completions, so the menu
  does not appear on ordinary sentences. Git commit messages and plain text get no
  completion. In LaTeX, completion appears after things like `\ref{` and `\cite{`;
  in Markdown, inside link syntax.
- To change the accept key, set `keymap.preset` in `completion.nix` to
  `"super-tab"` (Tab accepts) or `"enter"` (Enter accepts).

## Language servers

| Language | Server |
|---|---|
| Python | basedpyright |
| C / C++ / CUDA / proto | clangd |
| Nix | nixd |
| LaTeX | texlab |
| Markdown | marksman |
| JSON | jsonls |

Keys, active in any buffer with an attached server:

| Key | Action |
|---|---|
| `gd` | Go to definition |
| `gr` | List references |
| `K` | Hover docs |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `<leader>f` | Format the buffer |
| `[d` / `]d` | Previous / next diagnostic |

`:checkhealth vim.lsp` shows which servers are attached to the current buffer.

## Git signs

Changed lines are marked `+`, `~` and `-` in the sign column.

| Key | Action |
|---|---|
| `]c` / `[c` | Next / previous hunk |
| `<leader>hp` | Preview the hunk |
| `<leader>hs` | Stage the hunk |
| `<leader>hr` | Reset the hunk |

## Linting

`.proto` files are linted with `buf` on save, on entering the buffer, and when
leaving insert mode. Results appear as normal diagnostics, so `[d` / `]d` work.
