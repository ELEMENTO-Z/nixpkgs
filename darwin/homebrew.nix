{ config, ... }:

{
  system.activationScripts.extraUserActivation.text =
    config.system.activationScripts.homebrew.text;

  homebrew.enable = true;
  homebrew.autoUpdate = true;
  homebrew.cleanup = "zap";

  homebrew.taps = [
    "homebrew/cask"
    "homebrew/cask-drivers"
    "homebrew/cask-fonts"
    "homebrew/cask-versions"
    "homebrew/core"
    "homebrew/services"
    "AdoptOpenJDK/openjdk"
    "koekeishiya/formulae"
    "coursier/formulas"
  ];

  homebrew.brews = [
    "coursier"
    # "kotlin"
    "luajit" # brew install --HEAD luajit
    "neovim" # brew install --HEAD neovim
    "node"
    "sbt"
    # "steam"
    "skhd"  
    "yabai"

    # Kubernetes
    "kubernetes-cli" # Already comes with docker
    "helm"
    "kubectx"
  ];

  homebrew.casks = [
    "adoptopenjdk11"
    "brave-browser-beta"
    "alfred"
    "caffeine"
    "docker"
    "evernote"
    "firefox"
    "flycut"
    "font-hack-nerd-font"
    "font-jetbrains-mono"
    "fork"
    "google-chat"
    "google-chrome"
    "google-drive-file-stream"
    "gpg-suite"
    "hammerspoon"
    "iterm2"
    "jetbrains-toolbox"
    "karabiner-elements"
    "notion"
    # "redis"
    "slack"
    "signal"
    "spotify"
    "telegram"
    "vlc"
    "virtualbox"
    "virtualbox-extension-pack"
    # "visual-studio-code-insiders"
    "whatsapp"
    "zoom"
    "zoomus"
  ];

  homebrew.masApps = {
    # "1Blocker" = 1107421413;
    # "1Password" = 1333542190;
    # DaisyDisk = 411643860;
    # "Dark Mode for Safari" = 1397180934;
    # Deliveries = 924726344;
    # Fantastical = 975937182;
    Keynote = 409183694;
    # "LG Screen Manager" = 1142051783;
    # MindNode = 1289197285;
    Numbers = 409203825;
    Pages = 409201541;
    # Patterns = 429449079;
    # Pixelmator = 407963104;
    # "Pixelmator Pro" = 1289583905;
    # Slack = 803453959;
    # SiteSucker = 442168834;
    # "Things 3" = 904280696;
    # "Type Fu" = 509818877;
    # Ulysses = 1225570693;
    # "WiFi Explorer" = 494803304;
    Xcode = 497799835;
  };
}
