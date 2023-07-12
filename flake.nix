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
    suhr-nur-packages = {
      url = github:suhr/nur-packages;
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    
    clash-meta = {
      url = github:FrnkPsycho/Clash.Meta/Alpha;
    };

    alejandra = {
      url = github:kamadorueda/alejandra;
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    home-manager = {
      url = github:nix-community/home-manager/master;
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    helix = {
      url = github:helix-editor/helix;
    };
    
    grub2-themes.url = github:vinceliuice/grub2-themes;
  };

}
