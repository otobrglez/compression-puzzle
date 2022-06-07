with import <nixpkgs> { config.allowBroken = true; };

stdenv.mkDerivation {
    name = "david-puzzle";
    buildInputs = [
      clojure
      # crystal_1_2
      dotnet-sdk_6
      elixir
      ghc
      git
      go_1_18
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
