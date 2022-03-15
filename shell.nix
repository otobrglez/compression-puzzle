with import <nixpkgs> {};

stdenv.mkDerivation {
    name = "david-puzzle";
    buildInputs = [
      clojure
      crystal
      dotnet-sdk_6
      elixir
      ghc
      git
      go_1_16
      jdk17_headless
      kotlin
      lua
      nodejs
      php
      python3
      R
      ruby_3_0
      rustc
      scala
      yarn
    ];
    shellHook = ''
      export PATH="$PWD/node_modules/.bin/:$PATH"
      mkdir -p $PWD/node_modules/.bin/
      yarn install
    '';
}
