{ config
, lib
, pkgs
, ...
}: {
  programs.fish = {
    enable = true;
    plugins = [
      {
        name = "babelfish";
        src = pkgs.fetchFromGitHub {
          owner = "bouk";
          repo = "babelfish";
          rev = "348cc55ff299bcdce307c4edc4a17e5747c07ff4";
          sha256 = "4cbR7pqbLc8RRwlP+bUDt53C6J7KtMEJtfxzSpO0Myw=";
        };
      }


      #        {
      #          name = "grc";
      #          src = pkgs.fishPlugins.grc.src;
      #        }
      #        {
      #          name = "done";
      #          src = pkgs.fishPlugins.done.src;
      #        }
    ];
    #loginShellInit = ''
#      if test (id --user $USER) -ge 1000 && test (tty) = "/dev/tty1"
#        exec sway
#      end
#    '';
    shellAliases = {
      nd = "cd /etc/nixos";
      swc = "sudo nixos-rebuild switch";
      swcv = "sudo nixos-rebuild switch --verbose";
      sduo = "sudo";
      # n = "neovide";
      off = "poweroff";
      proxy = "proxychains4 -f /home/riro/.config/proxychains/proxychains.conf";
      roll = "xrandr -o left && feh --bg-scale /home/riro/Pictures/Wallpapers/95448248_p0.png && sleep 0.5; picom --experimental-backend -b";
      rolln = "xrandr -o normal && feh --bg-scale /home/riro/Pictures/Wallpapers/秋の旅.jpg && sleep 0.5;  picom --experimental-backend -b";
      cat = "bat";
      kls = "exa";
      sl = "exa";
      ls = "exa";
      l = "exa -l";
      la = "exa -la";
      g = "lazygit";
    };
    shellInit = ''
      ${pkgs.starship}/bin/starship init fish | source
      set fish_color_normal normal
        set fish_color_command blue
        set fish_color_quote yellow
        set fish_color_redirection cyan --bold
        set fish_color_end green
        set fish_color_error brred
        set fish_color_param cyan
        set fish_color_comment red
        set fish_color_match --background=brblue
        set fish_color_selection white --bold --background=brblack
        set fish_color_search_match bryellow --background=brblack
        set fish_color_history_current --bold
        set fish_color_operator brcyan
        set fish_color_escape brcyan
        set fish_color_cwd green
        set fish_color_cwd_root red
        set fish_color_valid_path --underline
        set fish_color_autosuggestion grey
        set fish_color_user brgreen
        set fish_color_host normal
        set fish_color_cancel --reverse
        set fish_pager_color_prefix normal --bold --underline
        set fish_pager_color_progress brwhite --background=cyan
        set fish_pager_color_completion normal
        set fish_pager_color_description B3A06D --italics
        set fish_pager_color_selected_background --reverse
    '';
    functions = {
      fish_greeting = "";
      haskellEnv = ''
        nix-shell -p "haskellPackages.ghcWithPackages (pkgs: with pkgs; [ $argv ])"

      '';
    };
  };
}
