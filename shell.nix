with import <nixpkgs> {};

stdenv.mkDerivation {
    name = "david-puzzle";
    buildInputs = [
      dotnet-sdk_6
      go
      jdk17_headless
      nodejs
      python3
      ruby_3_0
      scala
    ];
    shellHook = ''
    '';
}
