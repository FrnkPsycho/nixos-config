{ config
, pkgs
, user
, ...
}: {
  environment.sessionVariables = rec {
    _JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=on";
    NEOVIDE_MULTIGRID = "1";
    NEOVIDE_WM_CLASS = "1";
    EDITOR = "hx";
    WLR_RENDERER = "vulkan";
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    NODE_PATH = "~/.npm-packages/lib/node_modules";
    PATH = [
      "\${XDG_BIN_HOME}"
      "/home/${user}/.npm-packages/bin"
      "/home/frnks/opt/riscv/bin"
      "/home/frnks/opt/riscv/riscv64-unknown-elf/bin"
    ];
  };

  environment.shellInit = ''
  gpg-connect-agent /bye
  export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  '';
}
