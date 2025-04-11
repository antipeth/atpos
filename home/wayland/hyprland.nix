{
  lib,
  username,
  host,
  pkgs,
  config,
  ...
}:

let
  # hyprplugins = inputs.hyprland-plugins.packages.${pkgs.system};
  inherit (import ../../hosts/${host}/env.nix)
    extraMonitorSettings
    KeyboardLayout
    WM
    ;
in
with lib;
mkIf (WM == "Hyprland") {
  xdg.portal = {
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
    ];
  };
  services = {
    hypridle = {
      settings = {
        general = {
          after_sleep_cmd = "hyprctl dispatch dpms on";
          ignore_dbus_inhibit = false;
          lock_cmd = "hyprlock";
        };
        listener = [
          {
            timeout = 900;
            on-timeout = "hyprlock";
          }
          {
            timeout = 1200;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
        ];
      };
    };
  };

  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = true;
        grace = 10;
        hide_cursor = true;
        no_fade_in = false;
      };
      image = [
        {
          path = "/home/${username}/.config/face.jpg";
          size = 150;
          border_size = 4;
          border_color = "rgb(0C96F9)";
          rounding = -1; # Negative means circle
          position = "0, 200";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    plugins = [
      pkgs.hyprlandPlugins.hy3
    ];
    extraConfig =
      let
        modifier = "SUPER";
      in
      concatStrings [
        ''
          env = _JAVA_AWT_WM_NONREPARENTING, 1
          env = AWT_TOOLKIT, MToolkit
          env = CLUTTER_BACKEND, wayland
          env = ELECTRON_OZONE_PLATFORM_HINT, wayland
          env = GDK_BACKEND, wayland
          env = GTK_USE_PORTAL, 1
          env = MOZ_ENABLE_WAYLAND, 1
          env = NIXOS_OZONE_WL, 1
          env = QT_AUTO_SCREEN_SCALE_FACTOR, 1
          env = QT_WAYLAND_DISABLE_WINDOWDECORATION, 1
          env = QT_QPA_PLATFORM=wayland
          env = QT_QPA_PLATFORMTHEME, qt5ct
          env = SDL_HINT_VIDEODRIVER, wayland
          env = SDL_VIDEODRIVER, wayland
          # env = XDG_CURRENT_DESKTOP, Hyprland
          env = XDG_SESSION_TYPE, wayland
          # env = XDG_SESSION_DESKTOP, Hyprland

          env = GTK_IM_MODULE,
          env = QT_IM_MODULE, fcitx
          env = SDL_IM_MODULE, fcitx
          env = XMODIFIERS, @im=fcitx
          env = EDITOR, nvim


          # exec-once = dbus-update-activation-environment --systemd --all
          # exec-once = systemctl --user import-environment QT_QPA_PLATFORMTHEME WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
          exec-once = killall -q swww;sleep .5 && swww-daemon
          exec-once = killall -q waybar;sleep .5 && waybar
          exec-once = killall -q swaync;sleep .5 && swaync
          exec-once = nm-applet --indicator
          exec-once = lxqt-policykit-agent
          exec-once = sleep 1.5 && swww img /home/${username}/Pictures/Wallpapers/blackhole.jpg
          exec-once = fcitx5 -d -r
          monitor=,preferred,auto,1

          # monitor= HDMI-A-1, 3840x2160@60,0x0,1
          # monitor= DP-1, 3840x2160@60,0x0,1
          # monitor = eDP-2, 2560x1440@60,0x2160,1
          ${extraMonitorSettings}
          general {
            gaps_in = 6
            gaps_out = 8
            border_size = 2
            layout = hy3
            resize_on_border = true
            col.active_border = rgb(${config.stylix.base16Scheme.base08}) rgb(${config.stylix.base16Scheme.base0C}) 45deg
            col.inactive_border = rgb(${config.stylix.base16Scheme.base01})
          }
          input {
            kb_layout = ${KeyboardLayout}
            kb_options = grp:alt_shift_toggle
            kb_options = caps:esc
            follow_mouse = 1
            touchpad {
              natural_scroll = true
              disable_while_typing = true
              scroll_factor = 0.8
            }
            sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
            accel_profile = flat
          }
          windowrule = noborder,^(wofi)$
          windowrule = center,^(wofi)$
          windowrule = center,^(steam)$
          windowrule = float, nm-connection-editor|blueman-manager
          windowrule = float, swayimg|vlc|Viewnior|pavucontrol
          windowrule = float, nwg-look|qt5ct|mpv
          windowrule = float, zoom
          windowrulev2 = stayfocused, title:^()$,class:^(steam)$
          windowrulev2 = minsize 1 1, title:^()$,class:^(steam)$
          windowrulev2 = opacity 0.9 0.7, class:^(Brave)$
          windowrulev2 = opacity 0.9 0.7, class:^(thunar)$
          gestures {
            workspace_swipe = true
            workspace_swipe_fingers = 3
          }
          misc {
            initial_workspace_tracking = 0
            mouse_move_enables_dpms = true
            key_press_enables_dpms = false
          }
          animations {
            enabled = yes
            bezier = wind, 0.05, 0.9, 0.1, 1.05
            bezier = winIn, 0.1, 1.1, 0.1, 1.1
            bezier = winOut, 0.3, -0.3, 0, 1
            bezier = liner, 1, 1, 1, 1
            animation = windows, 1, 6, wind, slide
            animation = windowsIn, 1, 6, winIn, slide
            animation = windowsOut, 1, 5, winOut, slide
            animation = windowsMove, 1, 5, wind, slide
            animation = border, 1, 1, liner
            animation = fade, 1, 10, default
            animation = workspaces, 1, 5, wind
          }
          decoration {
            rounding = 10
            blur {
                enabled = true
                size = 5
                passes = 3
                new_optimizations = on
                ignore_opacity = off
            }
          }
          plugin {

          }
          dwindle {
            pseudotile = true
            preserve_split = true
          }
          # Shortcuts
          bind = ${modifier},Return,exec,alacritty
          bind = ${modifier},L,exec,pkill wlogout || wlogout
          bind = ${modifier},SPACE,exec,pkill fuzzel || fuzzel
          bind = ${modifier},Y,exec,alacritty -e yazi
          bind = ${modifier},W,exec,brave

          # Toggle some programs
          bind = ${modifier}SHIFT,N,exec,swaync-client -rs
          bind = ${modifier},C,exec,hyprpicker -a
          bind = ${modifier}ALT,W,exec,wallsetter

          # Screenshot
          bind = ${modifier}SHIFT,S,exec,grim -g "$(slurp)" - | swappy -f -
          bind = ${modifier}CTRL,S,exec,grim -g "$(hyprctl clients -j | jq '.[] | select(.hidden | not) | "\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' -r | slurp)" - | swappy -f -
          bind = ${modifier}ALT,S,exec,grim - | wl-copy -t image/png;notify-send "Screenshot copied to clipboard"

          # Workspace jumping
          bind = ${modifier},1,workspace,1
          bind = ${modifier},2,workspace,2
          bind = ${modifier},3,workspace,3
          bind = ${modifier},4,workspace,4
          bind = ${modifier},5,workspace,5
          bind = ${modifier},6,workspace,6
          bind = ${modifier},7,workspace,7
          bind = ${modifier},8,workspace,8
          bind = ${modifier},9,workspace,9
          bind = ${modifier},0,workspace,10

          # Window actions
          bind = ${modifier},Q,hy3:killactive,
          bind = ${modifier},F,fullscreen,
          bind = ${modifier}SHIFT,F,togglefloating,
          bind = ${modifier}SHIFT,I,togglesplit,
          bindm = ${modifier},mouse:272,movewindow
          bindm = ${modifier},mouse:273,resizewindow

          # Window movement
          bind = ${modifier}SHIFT,left,hy3:movewindow,l
          bind = ${modifier}SHIFT,right,hy3:movewindow,r
          bind = ${modifier}SHIFT,up,hy3:movewindow,u
          bind = ${modifier}SHIFT,down,hy3:movewindow,d
          bind = ${modifier}SHIFT,h,hy3:movewindow,l
          bind = ${modifier}SHIFT,l,hy3:movewindow,r
          bind = ${modifier}SHIFT,k,hy3:movewindow,u
          bind = ${modifier}SHIFT,j,hy3:movewindow,d

          bind = ${modifier}CTRL, 1, movetoworkspacesilent, 1
          bind = ${modifier}CTRL, 2, movetoworkspacesilent, 2
          bind = ${modifier}CTRL, 3, movetoworkspacesilent, 3
          bind = ${modifier}CTRL, 4, movetoworkspacesilent, 4
          bind = ${modifier}CTRL, 5, movetoworkspacesilent, 5
          bind = ${modifier}CTRL, 6, movetoworkspacesilent, 6
          bind = ${modifier}CTRL, 7, movetoworkspacesilent, 7
          bind = ${modifier}CTRL, 8, movetoworkspacesilent, 8
          bind = ${modifier}CTRL, 9, movetoworkspacesilent, 9
          bind = ${modifier}CTRL, 0, movetoworkspacesilent, 10

          bind = ${modifier}SHIFT,1,movetoworkspace,1
          bind = ${modifier}SHIFT,2,movetoworkspace,2
          bind = ${modifier}SHIFT,3,movetoworkspace,3
          bind = ${modifier}SHIFT,4,movetoworkspace,4
          bind = ${modifier}SHIFT,5,movetoworkspace,5
          bind = ${modifier}SHIFT,6,movetoworkspace,6
          bind = ${modifier}SHIFT,7,movetoworkspace,7
          bind = ${modifier}SHIFT,8,movetoworkspace,8
          bind = ${modifier}SHIFT,9,movetoworkspace,9
          bind = ${modifier}SHIFT,0,movetoworkspace,10

          bind = ${modifier}CONTROL,right,workspace,e+1
          bind = ${modifier}CONTROL,left,workspace,e-1
          bind = ${modifier},mouse_down,workspace, e+1
          bind = ${modifier},mouse_up,workspace, e-1

          # Special Workspace
          bind = ${modifier}SHIFT,Tab,movetoworkspace,special
          bind = ${modifier},Tab,togglespecialworkspace

          # Window focus movement
          bind = ${modifier},left,hy3:movefocus,l
          bind = ${modifier},right,hy3:movefocus,r
          bind = ${modifier},up,hy3:movefocus,u
          bind = ${modifier},down,hy3:movefocus,d
          bind = ${modifier},h,hy3:movefocus,l
          bind = ${modifier},l,hy3:movefocus,r
          bind = ${modifier},k,hy3:movefocus,u
          bind = ${modifier},j,hy3:movefocus,d
          bind = ALT,Tab,cyclenext
          bind = ALT,Tab,bringactivetotop

          # Volume control
          bind = ,XF86AudioRaiseVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
          bind = ,XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
          binde = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle

          # Playback control
          bind = ,XF86AudioPlay, exec, playerctl play-pause
          bind = ,XF86AudioPause, exec, playerctl play-pause
          bind = ,XF86AudioNext, exec, playerctl next
          bind = ,XF86AudioPrev, exec, playerctl previous

          # Brightness control
          bind = ,XF86MonBrightnessDown,exec,brightnessctl set 5%-
          bind = ,XF86MonBrightnessUp,exec,brightnessctl set +5%
        ''
      ];
  };
}
