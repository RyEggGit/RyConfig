{ config, pkgs, ... }:

{
  home.username = "ryegg";
  home.homeDirectory = "/Users/ryegg";
  home.stateVersion = "24.05"; # leave this fixed forever

  # targets.darwin = {
  #   linkApps.enable = true;
  # };

  # Let Home Manager manage itself
  programs.home-manager.enable = true;

  # Terminal - Ghosty
  programs.ghostty = {
    enable = true;
    package = if pkgs.stdenv.isDarwin then pkgs.ghostty-bin else pkgs.ghostty;
    enableBashIntegration = true;
    enableZshIntegration = true;
    settings = {
      theme = "Abernathy";
      background-opacity = 0.90;
    };
  };

  # Shell
  programs.zsh = {
    enable = true;
    enableCompletion = true;
  };

  # Neovim Config
  xdg.configFile."nvim/init.lua".source = ./nvim/init.lua;

  # Zed Config 
  xdg.configFile."zed/settings.json".text = builtins.toJSON {
    # This is really important since Zed's autoupdater will mess
    # with Nix's installation and cause broken sym links, etc... 
    # It was a mess last time :(
    auto_update = false;  
  };

  # Prompt
  programs.starship.enable = true;

  home.packages = with pkgs; [
    git
    gh
    ripgrep
    fd
    fzf
    bat
    tree
    tailscale
    spotify
    raycast
    zed-editor

    # Build tooling (important for Rust -sys crates)
    pkg-config
    zlib
    uv 

    # Language servers
    nixd
    rust-analyzer
    cargo
    rustc
    rustfmt
    zls
  ];

  # Neovim Config
  programs.neovim = {
    enable = true;
    withRuby = false;
    withPython3 = false;
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
    ];
  };

  # Git config
  programs.git = {
    enable = true;
    settings.user.name = "ryegg";
    settings.user.email = "reggens@uwaterloo.ca";
    settings.push.autoSetupRemote = true;
    settings.alias.checkout = "co";
  };

  # Environment variables
  home.sessionVariables = {
    EDITOR = "nvim";
  };

}
