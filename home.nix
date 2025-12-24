{ config, pkgs, ... }:

{
  home.username = "ryegg";
  home.homeDirectory = "/Users/ryegg";
  home.stateVersion = "24.05"; # leave this fixed forever

  # Let Home Manager manage itself
  programs.home-manager.enable = true;

  # Shell
  programs.zsh = {
    enable = true;
    enableCompletion = true;
  };

  # Ghostty config
  xdg.configFile."ghostty/config".text = ''
   font-family = "JetBrains Mono"
   font-size = 13

   theme = Catppuccin Frappe


   cursor-style = block
   window-padding-x = 8
   window-padding-y = 8

   keybind = ctrl+shift+c=copy_to_clipboard
   keybind = ctrl+shift+v=paste_from_clipboard
  '';

  # Prompt
  programs.starship.enable = true;

  # Core CLI tools
  home.packages = with pkgs; [
    git
    neovim
    ripgrep
    fd
    fzf
    bat
    tree
  ];

  # Git config
  programs.git = {
    enable = true;
    userName = "Ryan Egg";
    userEmail = "reggens@uwaterloo.ca";
  };

  # Environment variables
  home.sessionVariables = {
    EDITOR = "nvim";
  };
}

