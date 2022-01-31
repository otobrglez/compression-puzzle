with import <nixpkgs> {};

stdenv.mkDerivation {
    name = "david-puzzle";
    buildInputs = [
      jdk17_headless
      scala
      python3
      nodejs
    ];
    shellHook = ''
    '';
}
