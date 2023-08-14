# flake + home-manager NixOS configurations

Home managing with [home-manager](https://github.com/nix-community/home-manager)  

## Usage
__Before deployment, customizing `hardware.nix` and `network.nix`  in `./hosts/`__

flake outputs:  

```console
> nix flake show github:frnkpsycho/nixos-config
github:frnkpsycho/nixos-config/22337a8c53fcb31eb9c5109b67bed9ed4fdc1269
└───nixosConfigurations
    ├───frnks: NixOS configuration
```  
  
```
|Type|Program|
|---|---|
|Editor|[helix](https://github.com/oluceps/nixos-config/tree/pub/home/programs/helix)|
|Shell|[fish](https://github.com/oluceps/nixos-config/tree/pub/home/programs/fish)|
|Terminal|[wezterm](https://github.com/oluceps/nixos-config/tree/pub/home/programs/wezterm)|


## Contents
+ hosts: host-specific configuration  
+ home: home-manager config  
+ modules: as its name  
+ modules/packs: self-packaged softwares


## Directory structure  
```console  
> tree
.
├── boot.nix
├── conf.nix.backup
├── flake.lock
├── flake.nix
├── hardware-conf.nix.backup
├── home
│   ├── default.nix
│   ├── home.nix
│   └── programs
│       ├── bspwm
│       │   ├── bspwmrc
│       │   ├── default.nix
│       │   └── sxhkdrc
│       ├── chrome
│       │   └── default.nix
│       ├── default.nix
│       ├── fish
│       │   └── default.nix
│       ├── helix
│       │   ├── config
│       │   │   ├── config.toml
│       │   │   ├── languages.toml
│       │   │   └── themes
│       │   │       └── catppuccin_macchiato.toml
│       │   └── default.nix
│       ├── kitty.nix
│       ├── nnn.nix
│       ├── nushell
│       │   ├── config.nu
│       │   ├── default.nix
│       │   └── env.nu
│       ├── ranger
│       │   └── default.nix
│       ├── starship.nix
│       ├── sway
│       │   └── default.nix
│       ├── waybar
│       │   ├── default.nix
│       │   └── waybar.css
│       └── wezterm
│           ├── catppuccin.lua
│           ├── default.nix
│           └── wezterm.lua
├── hosts
│   ├── default.nix
│   ├── frnks
│   │   ├── default.nix
│   │   ├── hardware.nix
│   │   └── network.nix
│   └── kaambl
│       ├── default.nix
│       ├── hardware.nix
│       └── network.nix
├── LICENSE
├── misc.nix
├── modules
│   ├── blog
│   │   └── default.nix
│   ├── clash-m
│   │   └── default.nix
│   ├── default.nix
│   ├── foot
│   │   └── foot.ini
│   ├── hyprland
│   │   ├── config.nix
│   │   └── default.nix
│   ├── hysteria
│   │   ├── config.nix
│   │   └── default.nix
│   ├── packs
│   │   ├── clash-m
│   │   │   └── default.nix
│   │   ├── clash-p
│   │   │   └── default.nix
│   │   ├── glowsans
│   │   │   └── default.nix
│   │   ├── Graphite-cursors
│   │   │   └── default.nix
│   │   ├── maple-font
│   │   │   └── default.nix
│   │   ├── opensk-udev-rules
│   │   │   └── default.nix
│   │   ├── plangothic
│   │   │   └── default.nix
│   │   ├── RustPlayer
│   │   │   └── default.nix
│   │   ├── san-francisco
│   │   │   └── default.nix
│   │   ├── sing-box
│   │   │   └── default.nix
│   │   └── v2ray-plugin
│   │       └── default.nix
│   ├── polybar
│   │   ├── config.ini
│   │   └── default.nix
│   ├── sing-box
│   │   └── default.nix
│   └── ss
│       └── default.nix
├── overlay.nix
├── packages.nix
├── README.md
├── screenshot.png
├── secrets
│   ├── secrets.nix
│   ├── sing.age
│   └── ssconf.age
├── services.nix
├── shell.nix
├── sysvars.nix
└── users.nix
```  

## Resources  
Excellent configurations that I've learned and copied:  
+ [NickCao/flakes](https://github.com/NickCao/flakes)  
+ [ocfox/nixos-config](https://github.com/ocfox/nixos-config)  
+ [Clansty/flake](https://github.com/Clansty/flake)  
+ [fufexan/dotfiles](https://github.com/fufexan/dotfiles)  
+ [gvolpe/nix-config](https://github.com/gvolpe/nix-config)

[NixOS-CN-telegram](https://github.com/nixos-cn/NixOS-CN-telegram)


