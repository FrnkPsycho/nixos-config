{ config
, pkgs
, user
, ...
}: {
  environment.sessionVariables = rec {
    _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2 -Dawt.useSystemAAFontSettings=on";
    NEOVIDE_MULTIGRID = "1";
    NEOVIDE_WM_CLASS = "1";
    EDITOR = "hx";
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    NODE_PATH = "~/.npm-packages/lib/node_modules";
    DOTNET_ROOT = "${pkgs.dotnet-sdk}";
    PATH = [
      "\${XDG_BIN_HOME}"
      "/home/${user}/.npm-packages/bin"
      "/home/frnks/opt/riscv/bin"
      "/home/frnks/opt/riscv/riscv64-unknown-elf/bin"
    ];
  };
}
