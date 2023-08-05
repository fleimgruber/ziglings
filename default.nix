let
  pkgs = import <nixpkgs>{};
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
    ++ (with pkgs; with llvmPackages_16; [ clang clang-unwrapped lld llvm ]);
  hardeningDisable = [ "all" ];
  shellHook = ''
    export PATH=/home/fps/dev/zig-bootstrap/out/zig-x86_64-linux-musl-native/bin:$PATH
    export PATH=/home/fps/dev/zig/build/stage3/bin:$PATH
  '';
}
