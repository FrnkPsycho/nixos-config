{
  description = "a nixos flake";
  outputs = inputs:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations = (
        import ./hosts {
          inherit inputs system;
        }
      );
    };

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;
    nixpkgs-unstable.url = github:NixOS/nixpkgs/nixos-unstable;
    nixpkgs-tempwps.url = github:NixOS/nixpkgs?rev=3c575a659f10a8564a1c4a661570ee933e31ea2e;
    nixpkgs-wlroots.url = github:FrnkPsycho/nixpkgs?rev=55856c9b8c4ac3c168c03a064e3e51e028fe3b05;
    flake-utils.url = github:numtide/flake-utils;
    nix-colors.url = github:misterio77/nix-colors;
    mach-nix.url = github:DavHau/mach-nix;
    nur.url = github:nix-community/NUR;
    
    nur-pkgs = {
      url = github:oluceps/nur-pkgs;
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    my-nur-pkgs = {
      url = github:FrnkPsycho/nurpkgs;
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      
    };

    nixpkgs-wayland = {
      url = "github:nix-community/nixpkgs-wayland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
  };
    
    clash-meta = {
      url = github:FrnkPsycho/Clash.Meta/Alpha;
    };

    alejandra.url = "github:kamadorueda/alejandra";
    home-manager.url = "github:nix-community/home-manager";
    helix.url = "github:helix-editor/helix";
    hyprland.url = "github:hyprwm/Hyprland";
    android-nixpkgs.url = "github:tadfisher/android-nixpkgs";   
    grub2-themes.url = github:vinceliuice/grub2-themes;
  };

}
