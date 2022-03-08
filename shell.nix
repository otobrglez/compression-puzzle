with import <nixpkgs> {};

stdenv.mkDerivation {
    name = "david-puzzle";
    buildInputs = [
      lua
      clojure
      dotnet-sdk_6
      elixir
      git
      go_1_16
      jdk17_headless
      kotlin
      nodejs
      python3
      ruby_3_0
      scala
      ghc
      rustc
      yarn
      php
    ];
    shellHook = ''
      export PATH="$PWD/node_modules/.bin/:$PATH"
      mkdir -p $PWD/node_modules/.bin/
      yarn install
    '';
}
