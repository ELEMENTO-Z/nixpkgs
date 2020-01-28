self: super: {

  # Update Nix user enviroment
  nixuser-rebuild-macos = super.writeShellScriptBin "nixuser-rebuild" ''
    nix-env -riA nixpkgs.myMacosEnv
    ${self.pkgs.nixuser-simlink-apps}/bin/nixuser-simlink-apps
  '';

  # Simlink macOS apps installed via Nix into ~/Applications
  nixuser-simlink-apps = super.writeShellScriptBin "nixuser-simlink-apps" ''
    for app in $(find ~/Applications -name '*.app')
    do
      if test -L $app && [[ $(readlink -f $app) == /nix/store/* ]]; then
        rm $app
      fi
    done

    for app in $(find ~/.nix-profile/Applications/ -name '*.app' -exec readlink -f '{}' \;)
    do
      ln -s $app ~/Applications/$(basename $app)
    done
  '';

  # Update Nix on macOS
  nix-update = super.writeShellScriptBin "nix-update" ''
    sudo -i sh -c 'nix-channel --update && nix-env -iA nixpkgs.nix && launchctl remove org.nixos.nix-daemon && launchctl load /Library/LaunchDaemons/org.nixos.nix-daemon.plist'
  '';

  # Update Homebrew pagkages/apps
  brew-bundle = super.writeShellScriptBin "brewb" ''
    brew update
    brew bundle --file=~/.config/nixpkgs/Brewfile
  '';

  # Remove Homebrew pakages/apps not in Brewfile
  brew-bundle-cleanup = super.writeShellScriptBin "brewb-cleanup" ''
    brew bundle cleanup --zap $1 --file=~/.config/nixpkgs/Brewfile
  '';

  # Update all the things
  update-all-macos = super.writeShellScriptBin "update-all" ''
    nix-channel --update
    ${self.pkgs.nixuser-update-mypkgs}/bin/nixuser-update-mypkgs
    printf "\nRebuilding Nix user enviroment\n"
    ${self.pkgs.nixuser-rebuild-macos}/bin/nixuser-rebuild
    printf "\nUpdating Homebrew bundle\n"
    ${self.pkgs.brew-bundle}/bin/brewb
  '';

  myMacosEnv = super.buildEnv {
    name = "macOSEnv";
    paths = with self.pkgs; [
      myCommonEnv

      m-cli
      terminal-notifier
      myGems.vimgolf

      # My convinience shell scripts
      nixuser-rebuild-macos
      nix-update
      brew-bundle
      brew-bundle-cleanup
      update-all-macos
    ];
  };
}
