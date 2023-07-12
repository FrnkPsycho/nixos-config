{ config
, pkgs
, user
, ...
}: {
  environment.sessionVariables = rec {
    _JAVA_OPTIONS = "-Dsun.java2d.uiScale=2 -Dawt.useSystemAAFontSettings=on";
    #GDK_SCALE = "2";
    #GDK_DPI_SCALE = "0.5";
    NEOVIDE_MULTIGRID = "1";
    NEOVIDE_WM_CLASS = "1";
    EDITOR = "hx";
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    NODE_PATH = "~/.npm-packages/lib/node_modules";
    DOTNET_ROOT = "${pkgs.dotnet-sdk}";
    #LD_PRELOAD = "${pkgs.alsa-oss}/lib/libaoss.so";
    #JAVA_HOME = "${pkgs.jdk17}/lib/openjdk";
    #JAVA_8_HOME = "${pkgs.jdk8}/lib/openjdk";
    #JAVA_11_HOME = "${pkgs.jdk11}/lib/openjdk";
    #JAVA_17_HOME = "${pkgs.jdk17}/lib/openjdk";
    #JAVA_19_HOME = "${pkgs.jdk}/lib/openjdk";
    #JFX_HOME = "/home/frnks/opt/javafx17/lib";
    PATH = [
      "\${XDG_BIN_HOME}"
      "/home/${user}/.npm-packages/bin"
      "/home/frnks/opt/riscv/bin"
      "/home/frnks/opt/riscv/riscv64-unknown-elf/bin"
    ];
  };
}
