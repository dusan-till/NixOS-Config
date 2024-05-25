{ wallpaper, ... }: { config, ... }: {
  xdg.configFile = {
    "hypr/hyprlock.conf" = {
      enable = true;

      # Copied and adapted from catppuccin hyprlock config
      text = ''
source = ${config.catppuccin.sources.hyprland}/themes/${config.catppuccin.flavor}.conf

$accent = ${"$" + config.catppuccin.accent}
$accentAlpha = ${"$" + config.catppuccin.accent}Alpha
$font = ${config.gtk.font.name}

# GENERAL
general {
    disable_loading_bar = true
    hide_cursor = true
}

# BACKGROUND
background {
    monitor =
    path = ${wallpaper}
    blur_passes = 0
    color = $base
}

# TIME
label {
    monitor =
    text = cmd[update:30000] echo "$(date +"%R")"
    color = $text
    font_size = 90
    font_family = $font
    position = -30, 0
    halign = right
    valign = top
}

# DATE 
label {
    monitor = 
    text = cmd[update:43200000] echo "$(date +"%A, %d %B %Y")"
    color = $text
    font_size = 25
    font_family = $font
    position = -30, -150
    halign = right
    valign = top
}

# USER AVATAR

image {
    monitor = 
    path = ~/.face
    size = 100
    border_color = $accent

    position = 0, 75
    halign = center
    valign = center
}

# INPUT FIELD
input-field {
    monitor =
    size = 300, 60
    outline_thickness = 4
    dots_size = 0.2
    dots_spacing = 0.2
    dots_center = true
    outer_color = $accent
    inner_color = $surface0
    font_color = $text
    fade_on_empty = false
    placeholder_text = <span foreground="##$textAlpha"><i>󰌾 Logged in as </i><span foreground="##$accentAlpha">$USER</span></span>
    hide_input = false
    check_color = $accent
    fail_color = $red
    fail_text = <i>$FAIL <b>($ATTEMPTS)</b></i>
    capslock_color = $yellow
    position = 0, -35
    halign = center
    valign = center
}
      '';
    };
  };
}
