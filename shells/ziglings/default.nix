{
  mkShell,
  stdenv,
  zlib,
  pkgs,
  llvmPackages_16,
}:
mkShell {
  nativeBuildInputs = with pkgs; [
    cmake
    gdb
    libxml2
    ninja
    qemu
    wasmtime
    zlib
  ] ++ (with llvmPackages_16; [
    clang
    clang-unwrapped
    lld
    llvm
  ]);

  hardeningDisable = [ "all" ];

  shellHook = ''
    echo "setting shell hooks to include zig compiled from source"
    export PATH=/home/fps/dev/zig/build/stage3/bin:$PATH
  '';
}
