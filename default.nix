{ pkgs ? import <nixpkgs> { } }:
let
  inherit (pkgs.lib) recursiveUpdate;
  systems = [ "aarch64-linux" "aarch64-darwin" "x86_64-darwin" "x86_64-linux" ];
  config = system:
    (import (let lock = builtins.fromJSON (builtins.readFile ./flake.lock);
    in fetchTarball {
      url =
        "https://github.com/edolstra/flake-compat/archive/${lock.nodes.flake-compat.locked.rev}.tar.gz";
      sha256 = lock.nodes.flake-compat.locked.narHash;
    }) { src = ./.; }).defaultNix.outputs.packages.${system};
in builtins.foldl' (x: y: (recursiveUpdate x y)) { }
(builtins.map (system: (config system)) systems)
