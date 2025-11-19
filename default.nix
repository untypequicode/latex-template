{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  nativeBuildInputs = with pkgs.buildPackages; [
    just
    texliveFull
    texlab
  ];
}
