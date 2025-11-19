{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    just
    texlab
    (texlive.combine {
      inherit (texlive) scheme-basic
        # Packages de base requis
        latex-bin
        latexmk

        # Tes packages du preamble.tex
        amsmath
        amsfonts
        babel
        babel-french
        carlisle
        ec
        geometry
        graphics
        hyperref
        setspace
        fancyhdr
        float

        # Dépendances communes
        etoolbox
        pdftexcmds
        tools
        ;
    })
  ];
}
