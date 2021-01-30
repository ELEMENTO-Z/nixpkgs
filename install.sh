#!/usr/bin/env bash

nix build .#darwinConfigurations.bootstrap.system

./result/sw/bin/darwin-rebuild switch --flake .#bootstrap

darwin-rebuild switch --flake .#MacBookPro
