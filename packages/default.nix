{ self, pkgs, system }:
let
  inherit (pkgs.lib) filterAttrs;
  addons = import ../firefox-addons { inherit (pkgs) fetchurl lib stdenv; };

in {
  vulnix-pre-commit = self.inputs.vulnix-pre-commit.packages.${system}.default;
} // (filterAttrs (name: val: name != "buildFirefoxXpiAddon") addons)

