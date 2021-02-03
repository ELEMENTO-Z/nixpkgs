#!/usr/bin/env bash

nix flake update --recreate-lock-file

nix build .#darwinConfigurations.MacBookPro.system

./result/sw/bin/darwin-rebuild switch --flake .#MacBookPro

