{ pkgs, ... }:

{
  home.packages = [
    (pkgs.texlive.combine {
      inherit (pkgs.texlive)
        scheme-basic
        algorithms
        algorithm2e
        amsmath
        ifoddpage
        relsize
        makecell
        stmaryrd
        mathtools
        mathabx
        datatool
        xfrac
        placeins
        biber
        tracklang
        biblatex
        pgfplots
        booktabs
        breakurl
        cleveref
        float
        fontspec
        geometry
        hypdvips
        hyperref
        latexmk
        lineno
        listings
        ntheorem
        pgf # includes tikz
        xcolor
        xkeyval;
    })
  ];
}
