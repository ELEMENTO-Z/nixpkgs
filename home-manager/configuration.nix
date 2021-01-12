{ pkgs, lib, ... }:

{
  # Import config broken out into files
  imports = [
    ./git.nix
    # ./neovim.nix
    ./tmux.nix
    ./fish/default.nix
  ];


  ###########################
  # Configure misc packages #
  ###########################

  # Bat, a substitute for cat
  # https://github.com/sharkdp/bat
  programs.bat.enable = true;
  programs.bat.config = {
    theme = "Dracula";
  };

  # Direnv, load and unload environment variables depending on the current directory
  # https://direnv.net
  programs.direnv.enable = true;
  programs.direnv.enableFishIntegration = true;

  programs.fzf.enable = true;
  programs.fzf.enableFishIntegration = true;

  programs.gpg.enable = true;

  # Kitty terminal
  # Configuration options defined in overlays: `../overlays/kitty-configs.nix`
  # programs.kitty.enable = true;
  # programs.kitty.settings = pkgs.my-kitty-config // pkgs.my-kitty-light-config;
  # xdg.configFile."kitty/macos-launch-services-cmdline".text = "--listen-on unix:/tmp/mykitty";

  # Htop
  programs.htop.enable = true;
  programs.htop.showProgramPath = true;
  programs.htop.sortDescending = true;
  programs.htop.sortKey = "PERCENT_CPU";
  
  programs.jq.enable = true;
  programs.ssh.enable = true;

  # Zoxide, a faster way to navigate the filesystem
  # https://github.com/ajeetdsouza/zoxide
  programs.zoxide.enable = true;
  
  home.sessionVariables = {
      PGDATA = "/usr/local/var/postgres";
      JAVA_HOME = "$(/usr/libexec/java_home -v 11)";
      EDITOR = "nvim";
    };

  #######################
  # Additional packages #
  #######################

  home.packages = with pkgs; [
     any-nix-shell  # fish support for nix shell
    coursier
    colorls
    pstree
    bash # /bin/bash
    bat # cat replacement written in Rust
    cachix # Nix build cache
    curl # An old classic
    direnv # Per-directory environment variables
    fzf # Fuzzy finder
    fd
    ranger
    gnupg # gpg
    pinentry_mac # Necessary for GPG
    gradle
    htop # Resource monitoring
    httpie # Like curl but more user friendly
    jq # JSON parsing for the CLI
    jsonnet # Easy config language
    lorri # Easy Nix shell
    ngrok # Expose local HTTP stuff publicly
    niv # Nix dependency management
    nix-serve
    nixos-generators
    pre-commit # Pre-commit CI hook tool
    # python3 # Have you upgraded yet???
    ripgrep # grep replacement written in Rust
    tokei # Handy tool to see lines of code by language
    tree # Should be included in macOS but it's not
    vagrant # Virtualization made easy
    # vscode # My fav text editor if I'm being honest
    slack
    wget
    yarn # Node.js package manager
    youtube-dl #Download videos
    tldr
    ncdu
    exa
    graphviz # Graph visualization tools
    ffmpeg
    rename
    mpv # Command line video player
    ripgrep-all # ripgrep, but also search in PDFs, E-Books, Office documents, zip, tar.gz, and more
    
    zathura # A highly customizable and functional PDF viewer
    mupdf # Lightweight PDF, XPS, and E-book viewer and toolkit written in portable C
    ueberzug
    silver-searcher
    universal-ctags
    lazygit
    lazydocker

    shellcheck
    
    neofetch # A fast, highly customizable system info script
    dive # A tool for exploring each layer in a docker image
    gotop # A terminal based graphical activity monitor inspired by gtop and vtop

    nixpkgs-fmt
    cacert
    comma # run software from without installing it
    redis
    
    # gitAndTools.git
    gitAndTools.delta
    gitAndTools.gh
  ];

  # This value determines the Home Manager release that your configuration is compatible with. This
  # helps avoid breakage when a new Home Manager release introduces backwards incompatible changes.
  #
  # You can update Home Manager without changing this value. See the Home Manager release notes for
  # a list of state version changes in each release.
  home.stateVersion = "21.03";
}
