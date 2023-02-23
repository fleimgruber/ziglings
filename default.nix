let
  nixpkgs = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/915f5a5b3cc4f8ba206afd0b70e52ba4c6a2796b.tar.gz";
    sha256 = "06x6h5vdgnkxv70rbi6qmgrfjk9hq9aasi8dgc811m2ipbvq0hba";
  };
in
{ pkgs ? import nixpkgs { } }:
let
  pythonOnNix = import (
    builtins.fetchGit {
      ref = "main";
      rev = "d8a7fa21b76ac3b8a1a3fedb41e86352769b09ed";
      url = "https://github.com/on-nix/python";
    }) { nixpkgs = pkgs; };
  env = pythonOnNix.python39Env {
    name = "ziglings";
    projects = {
      "watchgod" = "latest";
      "python-lsp-server" = "latest";
    };
  };
in
pkgs.mkShell {
  nativeBuildInputs =
    [ env.dev ]
    ++ (with pkgs; [ cmake gdb ninja qemu zls ])
    ++ (with pkgs; with llvmPackages_14; [ clang clang-unwrapped lld llvm ]);
  hardeningDisable = [ "all" ];
  shellHook = ''
    export PATH=/home/fps/dev/zig-bootstrap/out/zig-x86_64-linux-musl-native/bin:$PATH
  '';
}
