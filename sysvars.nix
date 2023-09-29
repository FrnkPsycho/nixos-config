{ config
, pkgs
, user
, ...
}: {
  environment.sessionVariables = rec {
    # GDK_DPI_SCALE= "0.5";
    #GDK_BACKEND = "wayland";
    #CLUTTER_BACKEND = "wayland";
    #SDL_VIDEODRIVER = "wayland";
    # QT_QPA_PLATFORM = "wayland";
    # QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    # _JAVA_AWT_WM_NONREPARENTING = "1";  
    # STEAM_FORCE_DESKTOPUI_SCALING = "2.0";
    #XWAYLAND_NO_GLAMOR="1";
    
    GTK_THEME = "Orchis-Dark";
    # SDL_IM_MODULE = "fcitx";
    NEOVIDE_MULTIGRID = "1";
    NEOVIDE_WM_CLASS = "1";
    WLR_RENDERER = "vulkan";
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
    NODE_PATH = "~/.npm-packages/lib/node_modules";
    PATH = [
      "\${XDG_BIN_HOME}"
      "/home/${user}/.npm-packages/bin"
      # "/home/frnks/opt/riscv/bin"
      # "/home/frnks/opt/riscv/riscv64-unknown-elf/bin"
      "/home/frnks/Security/CTFTools/bin"
    ];
    EDITOR = "hx";
    TERMINAL = "kitty";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_SCALE_FACTOR = "1.5";
    _JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=on";
    QT_ENABLE_HIGHDPI_SCALING = "1";        
    CLUTTER_BACKEND = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_CACHE_HOME = "\${HOME}/.cache";
    XDG_CONFIG_HOME = "\${HOME}/.config";
    XDG_BIN_HOME = "\${HOME}/.local/bin";
    XDG_DATA_HOME = "\${HOME}/.local/share";
  };

  environment.shellInit = ''
  gpg-connect-agent /bye
  export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  '';
}
