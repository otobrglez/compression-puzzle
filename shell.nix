with import <nixpkgs> {};

stdenv.mkDerivation {
    name = "david-puzzle";
    buildInputs = [
      jdk17_headless
      python3
      nodejs
    ];
    shellHook = ''
    '';
}
