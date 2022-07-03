let
  nixpkgs = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/915f5a5b3cc4f8ba206afd0b70e52ba4c6a2796b.tar.gz";
  };
in
{ pkgs ? import nixpkgs { } }:
let
  pythonOnNix = import (
    builtins.fetchGit {
      ref = "main";
      rev = "d8a7fa21b76ac3b8a1a3fedb41e86352769b09ed";
      url = "https://github.com/on-nix/python";
    })
    {
      # (optional) You can override `nixpkgs` here
      pkgs = import <nixpkgs> { };
    };
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
    ++ (with pkgs; with llvmPackages_13; [ clang clang-unwrapped lld llvm ]);
  hardeningDisable = [ "all" ];
}
