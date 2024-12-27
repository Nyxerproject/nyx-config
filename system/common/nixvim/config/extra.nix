{pkgs, ...}: {
  extraConfigLuaPost = builtins.readFile ./extra.lua;

  extraPackages = with pkgs;
    [
      # runtime dependencies
      fd
      gdb
      ripgrep
      rustfmt
      clippy
      bacon
    ]
    ++ pkgs.lib.optionals pkgs.stdenv.isDarwin [
      # runtime dependencies
      gnused
    ];
}
