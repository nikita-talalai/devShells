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
            clang-tools
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
        devShells.ctf = pkgs.mkShell {
          buildInputs = with pkgs; [
            p7zip

            (zap.overrideAttrs (previousAttrs: {
              patches = [ ./zap-patch.patch ];
              }))
          ];
          _JAVA_AWT_WM_NONREPARENTING = 1;
        };
        devShells.js = pkgs.mkShell {
          buildInputs = with pkgs; [
            nodejs
          ];
        };
      };
    };
}
