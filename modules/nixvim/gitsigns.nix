{ ... }:

{
  programs.nixvim = {
    plugins.gitsigns = {
      enable = true;
      settings.signs = {
        add.text = "+";
        change.text = "~";
        delete.text = "-";
        topdelete.text = "‾";
        changedelete.text = "~";
      };
    };

    keymaps =
      let
        hunk = key: action: {
          mode = "n";
          inherit key;
          action = "<cmd>Gitsigns ${action}<cr>";
          options.silent = true;
        };
      in
      [
        (hunk "]c" "next_hunk")
        (hunk "[c" "prev_hunk")
        (hunk "<leader>hp" "preview_hunk")
        (hunk "<leader>hs" "stage_hunk")
        (hunk "<leader>hr" "reset_hunk")
      ];
  };
}
