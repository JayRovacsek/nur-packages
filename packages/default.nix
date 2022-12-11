{ self, pkgs, system }: {
  vulnix-pre-commit = self.inputs.vulnix-pre-commit.packages.${system}.default;
}
