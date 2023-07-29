{
    xdg.configFile."ranger/rc.conf".text = ''
      set preview_images true
      set preview_images_method kitty
      set cd_tab_fuzzy true
      set cd_bookmarks true
      # set viewmode multipane
      set vcs_aware true
      set draw_borders separators
      set dirname_in_tabs true
      set status_bar_on_top true
      default_linemode devicons
    ''
    ;

    xdg.configFile."ranger/rifle.conf".text = builtins.readFile ./rifle.conf + ''
      label open, has xdg-open = xdg-open "$@"
      label open, has code = code "$@" --enable-wayland-ime      
    '';

}
