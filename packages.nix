{ pkgs, inputs, ... }:
{
  # programs.ghc.package = pkgs.ghc.withPackages (hp: with hp; [ zlib ]);
  # programs.vscode.package = pkgs.vscode.fhsWithPackages (ps: with ps; [ rustup zlib gdb]);
  
  environment.systemPackages = with pkgs; [
    # blueman
    scanmem
    looking-glass-client
    # scream-receivers
    hashcat
    gnome.gnome-calculator
  
    autokey
    wineWowPackages.waylandFull
    winetricks
  
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
    wl-clipboard
    hyprpicker
    swaybg
    cliphist
    fuzzel
    libnotify
    udiskie
    #networkmanager_dmenu
    networkmanagerapplet
    cliphist
    grim
    slurp
  
    # kanshi
    qt5.qtwayland
    # sdkmanager
    android-tools
    php81
    # nzbget
    innoextract
    vkbasalt-cli
    amule
    gmtp
    javaPackages.openjfx17
    xorg.xprop
    binwalk
    pandoc
    # gobject-introspection
    # my-nur-pkgs.gameconqueror
    nix-prefetch-git
    readline
    intltool
    pwndbg
    glfw
    pkg-config
    alejandra
    gtk3
    # nautilus-open-any-terminal
    unar
    libtiff
    nasm
    file
    tree
    desktop-file-utils
    appimage-run
    # jdk
    jdk8
    jdk11
    # jdk17
    razergenie
    burpsuite
    easyeffects  
    input-remapper
    virtiofsd
    vulkan-caps-viewer
    john
    ascii
    packer
    unrar
    xorriso
    libguestfs
    p7zip
    lm_sensors
    mesa
    vulkan-tools
    steam-run
    dos2unix
    glib
    glibc
    bore
    xclip
    alsa-oss
    autoconf automake curl libmpc mpfr gmp gawk bison flex texinfo gperf libtool patchutils bc expat gnum4
    
    openal
    qt6.full
    # qt5.full
    zlib.dev
    zlib
    vistafonts-chs
    vistafonts-cht
    vistafonts
    corefonts
    
    flatpak
    gtk4
    libadwaita
    
    xdotool
    gparted
    gnome-browser-connector
    editorconfig-checker
    virt-manager
    doas
    hexyl
    jq
    fx
    fd
    choose
    duf
    procs
    dog
    arti
    onefetch
    snapper
    cachix
    android-tools
    qrencode
    wakelan
    netcat-gnu
    gdb


    # languages related
    nixpkgs-fmt
    zig
    lldb
    haskell-language-server
    gopls
    cmake-language-server
    zls
    android-file-transfer
    nixpkgs-review

    shfmt
    broot
    rust-analyzer
    pyright
    rnix-lsp
    kotlin-language-server
    sumneko-lua-language-server
    taplo-lsp
    taplo-cli
    yaml-language-server
    tree-sitter
    stylua
    black

    powertop

    zbar

    lazygit
    netcat
    bpftools

    inetutils
    imgcat

    # mongodb-tools
    tcpdump

    pciutils
    b3sum
    usbutils
    ranger
    w3m

    exa
    clash

    bat

    # mongodb

    mtr
    openssl_1_1

    tor
    iperf3
    ethtool
    nixpkgs-fmt
    dig
    btrfs-progs
    wireguard-tools
    gnupg
    nftables
    clang-tools
    libclang
    wget
    nixos-option
    lua
    proxychains
    go
    binutils
    libcap
    gnumake
    rustup
    nodejs-18_x
    yarn
    unzip
    ripgrep
    bash
    wget
    git
    zip
    whois
    neofetch
    htop
    lsof
    tree
    llvm
    clang
    gcc
    curl
    # jdk
    coreutils
    nix-index
    tmux
    dnsutils
    openssl
    docker
    docker-compose
   ]
   ++ 
   (
    with pkgs.gnomeExtensions; [
    #alttab-mod
    #transparent-top-bar
    #pano
    #unite
    #dash-to-dock
    #system-monitor-next
    #arcmenu
    #improved-workspace-indicator
    #forge
    #tiling-assistant
    #clipboard-indicator
    #gsconnect
    #just-perfection
   ]
   ) 
   ++
  [
    ( python310.withPackages (p: with p;[
          #uncompyle6
          minidump
          pygobject3
          pyperclip
          # black
          setuptools
          # z3-solver
          z3
          bitarray
          pycrypto
          flask
          numpy
          gmpy2
          pycryptodome
          chardet
          pwntools
          # maskpass
          
          # wordcloud
          qrcode
          matplotlib
          # pylsp-mypy

          fontforge

          pyzbar
          pymongo

          aiohttp
          loguru
          pillow
          dbus-python
          numpy
          redis
          requests
          uvloop

          fido2
          nrfutil
          tockloader
          intelhex
          colorama
          tqdm
          cryptography

          pandas
          requests
          pyrogram
          tgcrypto
          JPype1
          toml
          pyyaml
          tockloader
          colorama
          six
        ]
      )
    )
  ]
  ++
  (
    with pkgs.nodePackages; [
    # hexo-cli
    vscode-json-languageserver
    typescript-language-server
    node2nix
    markdownlint-cli2
    prettier
  ]
  ) 
  ++
  [
    ((vim_configurable.override { }).customize {
      name = "vim";
      # Install plugins for example for syntax highlighting of nix files
      vimrcConfig.packages.myplugins = with pkgs.vimPlugins; {
        start = [ vim-nix vim-lastplace ];
        opt = [ ];
      };
      vimrcConfig.customRC = ''
        " your custom vimrc
        set nocompatible
        set backspace=indent,eol,start
        " Turn on syntax highlighting by default
        syntax on
        
        :let mapleader = " "
        :map <leader>s :w<cr>
        :map <C-j> 5j
        :map <C-k> 5k
        :map qq    :q!<cr>

      '';
    }
    )
  ];
}
