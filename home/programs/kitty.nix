{ config
, lib
, pkgs
, ...
}: {
  programs.kitty = {
    enable = true;
    font = {
      name = "FiraCode Nerd Font Mono";
      size = 16;
    };
    settings = {
      background_opacity = "1";
      confirm_os_window_close = "0";
      # copy_on_select = "yes";
      
    };

    keybindings = {
      "cmd+t" = "new_tab";
      "cmd+j" = "next_tab";
      "cmd+k" = "previous_tab";
      "cmd+w" = "close_tab";
    };

    extraConfig = "

#font_family Noto Sans CJK SC
#italic_font auto
#bold_font   auto
#bold_italic_font auto

symbol_map U+4E00-U+9FFF,U+F900-U+FAFF Noto Sans CJK SC Regular

tab_bar_min_tabs            1
tab_bar_edge                bottom
tab_bar_style               powerline
tab_powerline_style         slanted
tab_title_template          {title}{' :{}:'.format(num_windows) if num_windows > 1 else ''}
     
# vim:ft=kitty

## name:     Catppuccin Kitty Frappe
## author:   Catppuccin Org
## license:  MIT
## upstream: https://github.com/catppuccin/kitty/blob/main/themes/frappe.conf
## blurb:    Soothing pastel theme for the high-spirited!



# The basic colors
foreground              #C6D0F5
background              #303446
selection_foreground    #303446
selection_background    #F2D5CF

# Cursor colors
cursor                  #F2D5CF
cursor_text_color       #303446

# URL underline color when hovering with mouse
url_color               #F2D5CF

# Kitty window border colors
active_border_color     #BABBF1
inactive_border_color   #737994
bell_border_color       #E5C890

# OS Window titlebar colors
wayland_titlebar_color system
macos_titlebar_color system

# Tab bar colors
active_tab_foreground   #232634
active_tab_background   #CA9EE6
inactive_tab_foreground #C6D0F5
inactive_tab_background #292C3C
tab_bar_background      #232634

# Colors for marks (marked text in the terminal)
mark1_foreground #303446
mark1_background #BABBF1
mark2_foreground #303446
mark2_background #CA9EE6
mark3_foreground #303446
mark3_background #85C1DC

# The 16 terminal colors

# black
color0 #51576D
color8 #626880

# red
color1 #E78284
color9 #E78284

# green
color2  #A6D189
color10 #A6D189

# yellow
color3  #E5C890
color11 #E5C890

# blue
color4  #8CAAEE
color12 #8CAAEE

# magenta
color5  #F4B8E4
color13 #F4B8E4

# cyan
color6  #81C8BE
color14 #81C8BE

# white
color7  #B5BFE2
color15 #A5ADCE
    ";
  };
}
