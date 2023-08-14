{ inputs, system, ... }:

let
  nixosSystem = inputs.nixpkgs.lib.nixosSystem;

  pkgs = import inputs.nixpkgs-unstable {
    inherit system;
    config.allowUnfree = true;
    config.permittedInsecurePackages = [ 
      "qtwebkit-5.212.0-alpha4"
      "electron-21.4.0"
      "openssl-1.1.1t"
      "openssl-1.1.1u"
      "openssl-1.1.1v"
    ];
    overlays = [
      (final: prev: {
        nur-pkgs = inputs.nur-pkgs.packages."${prev.system}";
        my-nur-pkgs = inputs.my-nur-pkgs.packages."${prev.system}";
      })
      inputs.nur.overlay
      inputs.android-nixpkgs.overlays.default
    ] ++ (import ../overlay.nix { inherit inputs system; });

  };

  sharedModules = [
    ../misc.nix
    ../users.nix
    ../boot.nix
    ../packages.nix
    ../sysvars.nix
    ../services.nix
    ../programs.nix
    {
      environment.systemPackages = with inputs; [
      ];
    }
  ] ++ (with inputs;[

    grub2-themes.nixosModules.default
    home-manager.nixosModules.home-manager

  ]) ++ (import ../modules);


in
{
  frnks = nixosSystem (
    let user = "frnks"; in
    {
      inherit system pkgs;
      specialArgs = { inherit inputs system user; };
      modules = (import ./frnks) ++ sharedModules;
    }
  );
}
