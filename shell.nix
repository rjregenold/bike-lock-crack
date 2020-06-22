with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "lock-crack";
  nativeBuildInputs = [
    nodejs
    nodePackages.node2nix

    # put addl build deps here
  ];

  buildInputs = [
    # put runtime deps here
  ];

  # set environment variables
  # EXAMPLE_ENV = 1;
}
