with import <nixpkgs> {};

stdenv.mkDerivation {
    name = "david-puzzle";
    buildInputs = [
      clojure
      dotnet-sdk_6
      go_1_16
      jdk17_headless
      nodejs
      python3
      ruby_3_0
      scala
    ];
    shellHook = ''
    '';
}
