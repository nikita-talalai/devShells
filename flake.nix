{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      perSystem = { pkgs, ... }: {

        devShells.c = pkgs.mkShell {
          buildInputs = with pkgs; [
            gcc
            gdb
          ];
        };
        devShells.asm = pkgs.mkShell {
          buildInputs = with pkgs; [
            nasm
            gcc
            gdb
            gnumake
          ];
        };
      };
    };
}
