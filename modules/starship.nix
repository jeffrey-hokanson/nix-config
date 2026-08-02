{ ... }:

{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      format = "$hostname[](fg:purple bg:blue)$directory[](fg:blue bg:green)$git_branch[](fg:green bg:yellow)$git_metrics$git_status$character";

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
        format = "[ ]($style)[$all_status$ahead_behind]($style)[ ]($style)";
        modified = "";
      };

      git_branch = {
        format = "[ $symbol $branch ]($style)";
	      symbol = "";
        style = "fg:white bg:green";
      };

      git_metrics = {
        format = "([+$added]($added_style))([-$deleted]($deleted_style))";
        # format = "([+$added]($added_style))[]($added_style)";
        added_style = "bold fg:black bg:yellow";
        deleted_style = "bold fg:red bg:yellow";
        disabled = false;
      };

      character = {
        success_symbol = "[](fg:yellow bg:green)[](fg:green)";
        error_symbol = "[](fg:yellow bg:red)[](fg:red)";
      };

      time = {
        disabled = true;
      };
    };
  };


}
