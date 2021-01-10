#!/usr/bin/env bash

nix build .#darwinConfigurations.bootstrap.system

./result/sw/bin/darwin-rebuild switch --flake .#bootstrap

/run/current-system/sw/bin/fish -c 'darwin-rebuild switch --flake .#MacBookPro'
