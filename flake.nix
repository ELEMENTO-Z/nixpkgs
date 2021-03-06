{
  description = "Pritam's Nix System Configs";

  inputs = {
    # Channels
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    nixpkgs-stable-darwin.url = "github:nixos/nixpkgs/nixpkgs-20.09-darwin";
    # nixos-stable.url = "github:nixos/nixpkgs/nixos-20.09";

    # nix-darwin
    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    # home-manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Fish plugins
    fish-plugin-done.url = "github:franciscolourenco/done";
    fish-plugin-done.flake = false;
    fish-plugin-humanize-duration.url = "github:fishpkg/fish-humanize-duration";
    fish-plugin-humanize-duration.flake = false;

    # Vim plugins
    # galaxyline-nvim.url = "github:glepnir/galaxyline.nvim";
    # galaxyline-nvim.flake = false;
    # gitsigns-nvim.url = "github:lewis6991/gitsigns.nvim";
    # gitsigns-nvim.flake = false;
    # lush-nvim.url = "github:rktjmp/lush.nvim";
    # lush-nvim.flake = false;
    # moses-lua.url = "github:Yonaba/Moses";
    # moses-lua.flake = false;
    # telescope-nvim.url = "github:nvim-telescope/telescope.nvim";
    # telescope-nvim.flake = false;
    # vim-haskell-module-name.url = "github:chkno/vim-haskell-module-name";
    # vim-haskell-module-name.flake = false;

    # Other sources
    comma.url = "github:Shopify/comma";
    comma.flake = false;
    neovim.url = "github:neovim/neovim?dir=contrib";
    neovim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, ... }@inputs:
  let
    overlaysModule = with inputs; system: { pkgs, ... }: {
      nixpkgs.overlays = [
        (self: super: {
          master = nixpkgs-master.legacyPackages.${system};
          stable =
            if pkgs.stdenv.isDarwin then
              nixpkgs-stable-darwin.legacyPackages.${system}
            else
              nixos-stable.legacyPackages.${system};
          comma  = import comma { inherit pkgs; };
          neovim-nightly = neovim.packages.${system}.neovim;
          mySources = {
            fish-plugin-done = fish-plugin-done;
            fish-plugin-humanize-duration = fish-plugin-humanize-duration;
            # galaxyline-nvim = galaxyline-nvim;
            # gitsigns-nvim = gitsigns-nvim;
            # lush-nvim = lush-nvim;
            # moses-lua = moses-lua;
            # telescope-nvim = telescope-nvim;
            # vim-haskell-module-name = vim-haskell-module-name;
          };
        })
      ] ++ map import ((import ./lsnix.nix) ./overlays);
    };
  in {

    darwinConfigurations = {

      bootstrap = inputs.darwin.lib.darwinSystem {
        modules = [ ./darwin/bootstrap.nix ];
      };

      MacBookPro = inputs.darwin.lib.darwinSystem {
        modules = [
          # Common configuration
          (overlaysModule "x86_64-darwin")
          ./darwin/configuration.nix

          # Host specific configuration
          {
            users.users.pritamkadam.home = "/Users/pritamkadam";
            networking.computerName = "pritamkadam";
            networking.hostName = "MacBook-Pro";
            networking.knownNetworkServices = [
              "Wi-Fi"
              "USB 10/100/1000 LAN"
            ];
          }
          inputs.home-manager.darwinModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.users.pritamkadam = import ./home-manager/configuration.nix;
          }
        ];
      };

    };
  };
}
