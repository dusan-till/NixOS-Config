# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, outputs, lib, config, pkgs, ... }: let
  nix-colors = inputs.nix-colors;
  nix-colors-lib = inputs.nix-colors.lib.contrib { inherit pkgs; };
in {
  imports = [
    ./emacs.nix
  ];

  nixpkgs = {
    overlays = [
      # Overlays from this flake
      outputs.overlays.additions
      outputs.overlays.modifications

      # Mozilla packages
      inputs.mozilla.overlay

      # Emacs
      inputs.emacs.overlays.default
    ];
    # Nixpkgs config
    config = {
      # Unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  nix = {
    package = pkgs.nixVersions.unstable;
    
    checkConfig = true;
    settings = {
      use-xdg-base-directories = true;
    };
  };

  home = {
    username = "duanin2";
    homeDirectory = "/home/duanin2";
    stateVersion = "23.11";

    packages = with pkgs; [
      keepassxc
      git-credential-keepassxc

      # Gaming
      prismlauncher
      vkbasalt
      replay-sorcery
      gamemode
      the-powder-toy

      # Ricing
      (pkgs.eww-systray.override {
        withWayland = true;
      })

      (pkgs.bottles.override {
        extraPkgs = pkgs: with pkgs; [
          gamescope_git
          vkbasalt
	        mangohud_git
          mangohud32_git
          gamemode
	        steam

          xterm

          # Dependencies
          libgdiplus
	        keyutils
	        libkrb5
	        libpng
	        libpulseaudio
	        libvorbis
	        stdenv.cc.cc.lib
	        xorg.libXcursor
	        xorg.libXi
	        xorg.libXinerama
	        xorg.libXScrnSaver
        ];	
      })
      qbittorrent

      libsForQt5.ark
      pcmanfm-qt
    ];
  };

  services.udiskie = {
    enable = true;
    automount = true;
  };

  # Color scheme
  colorScheme = nix-colors.colorSchemes.catppuccin-frappe;

  # Enable Hyprland Wayland compositor
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland = {
      enable = true;
      hidpi = true;
    };
    nvidiaPatches = true;

    systemdIntegration = true;
    recommendedEnvironment = true;
    extraConfig = ''
monitor = eDP-1,1920x1080@60,0x0,1

env = XCURSOR_SIZE,18

exec-once = ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1

input {
  kb_layout = cz
  kb_model = acer_laptop

  follow_mouse = 0

  touchpad {
    natural_scroll = false
  }

  sensitivity = 0
}

general {
  gaps_in = 4
  gaps_out = 8
  border_size = 2
  col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
  col.inactive_border = rgba(595959aa)

  layout = dwindle
}
decoration {
  rounding = 12
  blur {
    enabled = true
    size = 3
    passes = 2
    new_optimizations = true
  }

  drop_shadow = true
  shadow_range = 4
  shadow_render_power = 3
  col.shadow = rgba(1a1a1aee)
}
animations {
  enabled = true

  bezier = myBezier, 0.5, -0.2, 0.5, 1.2

  animation = windows, 1, 7, myBezier
  animation = windowsOut, 1, 7, myBezier, popin 80%
  animation = border, 1, 10, myBezier
  animation = borderangle, 1, 8, myBezier
  animation = fade, 1, 7, myBezier
  animation = workspaces, 1, 6, myBezier
}

dwindle {
  pseudotile true
  preserve_split true
}
master {
  new_is_master = true
}

gestures {
  workspace_swipe = false
}

$mod = SUPER
bind = $mod, Q, exec, ${pkgs.alacritty}/bin/alacritty
bind = $mod, C, killactive,
bind = $mod, H, movetoworkspacesilent, special
bind = $mod, S, togglespecialworkspace
bind = $mod, M, exit,
bind = $mod, V, togglefloating,
bind = $mod, R, exec, true # TODO: Add a system menu
bind = $mod, P, pseudo, # dwindle
bind = $mod, J, togglesplit, #dwindle

# Focus movement with arrow keys
bind = $mod, left, movefocus, l
bind = $mod, right, movefocus, r
bind = $mod, up, movefocus, u
bind = $mod, down, movefocus, d

# Workspace movement using number keys
bind = $mod, plus, workspace, 1
bind = $mod, ecaron, workspace, 2
bind = $mod, scaron, workspace, 3
bind = $mod, ccaron, workspace, 4
bind = $mod, rcaron, workspace, 5
bind = $mod, zcaron, workspace, 6
bind = $mod, yacute, workspace, 7
bind = $mod, aacute, workspace, 8
bind = $mod, iacute, workspace, 9
bind = $mod, eacute, workspace, 10
# Workspace movement using scroll wheel
bind = $mod, mouse_down, workspace, e+1
bind = $mod, mouse_up, workspace, e-1

# Workspace window movement using SHIFT and number keys
bind = $mod SHIFT, 1, movetoworkspace, 1
bind = $mod SHIFT, 2, movetoworkspace, 2
bind = $mod SHIFT, 3, movetoworkspace, 3
bind = $mod SHIFT, 4, movetoworkspace, 4
bind = $mod SHIFT, 5, movetoworkspace, 5
bind = $mod SHIFT, 6, movetoworkspace, 6
bind = $mod SHIFT, 7, movetoworkspace, 7
bind = $mod SHIFT, 8, movetoworkspace, 8
bind = $mod SHIFT, 9, movetoworkspace, 9
bind = $mod SHIFT, 0, movetoworkspace, 10

# Window operations using mouse buttons
bindm = $mod, mouse:272, movewindow
bindm = $mod, mouse:273, resizewindow
    '';
  };

  # Enable home-manager and git
  programs = let
    gpg = (import ./gpg.nix) { inherit config; };
    git = (import ./git.nix) { inherit pkgs; };
    ssh = import ./ssh.nix;
  in {
    inherit gpg git ssh;
    home-manager.enable = true;
    firefox = {
      enable = true;
      package = pkgs.latest.firefox-nightly-bin;
    };
    zsh = {
      enable = true;

      # Configuration
      enableAutosuggestions = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      autocd = true;
      defaultKeymap = "emacs";
      initExtra = ''
function launchbg() {
  sh -c "\
  exec $1 &" \
  &> /dev/null
}
'';

      # ZSH history settings
      history = {
        expireDuplicatesFirst = true;
        extended = true;
        ignoreSpace = true;
        path = "${config.home.homeDirectory}/.zsh_history";
        save = 100000;
      };
    };
    mangohud = {
      enable = true;
      package = pkgs.mangohud_git;

      settings = {
        # Display
        vsync = 0;

        # Basic info
        custom_text_center = "MangoHUD";
        time = true;
        time_format = "%X";

        # GPU
        gpu_temp = true;
        gpu_text = "GPU";
        gpu_load_change = true;
        gpu_load_value = "25,50,75";
        gpu_load_color = "41FC02,ADFC02,FC9002,FC1302";
        throttling_status = true;
        gpu_name = true;

        # CPU
        cpu_temp = true;
        cpu_text = "CPU";
        cpu_mhz = true;
        cpu_load_change = true;
        cpu_load_value = "25,50,75";
        cpu_load_color = "41FC02,ADFC02,FC9002,FC1302";

        # Battery info
        battery = true;
        battery_icon = true;
        battery_time = true;

        # FPS
        fps = true;
        fps_color_change = true;
        fps_value = "30,60";
        fps_color = "FC0202,FCFC02,23FC02";
        frametime = true;
        frame_timing = true;

        # Layout
        position = "top-left";
        round_corners = 6;
      };
    };
    alacritty = {
      enable = true;
      settings = {
        window = {
          padding = {
            x = 6;
            y = 6;
          };
          opacity = 0.8;
        };
        font = {
          family = "monospace";
          size = 10;
        };
        colors = {
          primary = {
            background = "#${config.colorScheme.colors.base00}";
            foreground = "#${config.colorScheme.colors.base05}";
          };
          cursor = {
            text = "#${config.colorScheme.colors.base00}";
            cursor = "#${config.colorScheme.colors.base05}";
          };
          normal = {
            black = "#${config.colorScheme.colors.base00}";
            red = "#${config.colorScheme.colors.base08}";
            green = "#${config.colorScheme.colors.base0B}";
            yellow = "#${config.colorScheme.colors.base0A}";
            blue = "#${config.colorScheme.colors.base0D}";
            magenta = "#${config.colorScheme.colors.base0E}";
            cyan = "#${config.colorScheme.colors.base0C}";
            white = "#${config.colorScheme.colors.base05}";
          };
          bright = {
            black = "#${config.colorScheme.colors.base03}";
            red = "#${config.colorScheme.colors.base08}";
            green = "#${config.colorScheme.colors.base0B}";
            yellow = "#${config.colorScheme.colors.base0A}";
            blue = "#${config.colorScheme.colors.base0D}";
            magenta = "#${config.colorScheme.colors.base0E}";
            cyan = "#${config.colorScheme.colors.base0C}";
            white = "#${config.colorScheme.colors.base07}";
          };
          indexed_colors = [
            { index = 16; color = "#${config.colorScheme.colors.base09}"; }
            { index = 17; color = "#${config.colorScheme.colors.base0F}"; }
            { index = 18; color = "#${config.colorScheme.colors.base01}"; }
            { index = 19; color = "#${config.colorScheme.colors.base02}"; }
            { index = 20; color = "#${config.colorScheme.colors.base04}"; }
            { index = 21; color = "#${config.colorScheme.colors.base06}"; }
          ];
        };
        cursor = {
          style = {
            shape = "Beam";
            blinking = "Always";
          };
        };
      };
    };
  };

  services = {
    syncthing = {
      enable = true;
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
