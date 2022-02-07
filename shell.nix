with import <nixpkgs> {};

stdenv.mkDerivation {
    name = "david-puzzle";
    buildInputs = [
      clojure
      dotnet-sdk_6
      git
      go_1_16
      jdk17_headless
      kotlin
      nodejs
      python3
      ruby_3_0
      scala
      ghc
      kotlin
    ];
    shellHook = ''
    '';
}
