{ inputs, system, user,... }:


let
  homeProfile = ./home.nix;
in
{
  home-manager = {
    useGlobalPkgs = true;
    users.${user} = {
      imports = [
        homeProfile
        inputs.hyprland.homeManagerModules.default
        inputs.android-nixpkgs.hmModule
      ];
    };
    extraSpecialArgs = { inherit inputs system user; };
  };

}
