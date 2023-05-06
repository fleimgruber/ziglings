{
  # flox environment
  #
  # To learn basics about flox commands see:
  #   https://floxdev.com/docs/basics
  # 
  # Check other options you can configure in this file:
  #   https://floxdev.com/docs/reference/flox-nix-config
  #
  # Get help:
  #   https://discourse.floxdev.com
  #
  # Happy hacking!

  # Look for more packages with `flox search` command.
  #packages.nixpkgs-flox.go = {};
  #packages.nixpkgs-flox.nodejs = {}

  # Set environment variables
  #environmentVariables.LANG = "en_US.UTF-8";

  # Run shell hook when you enter flox environment
  shell.hook = ''
    echo "setting shell hooks to include zig bootstrapped"
    export PATH=/home/fps/dev/zig-bootstrap/out/zig-x86_64-linux-musl-native/bin:$PATH
  '';
}
