{
  programs.waybar = {
    enable = true;
    settings = [
      {
        height = 20;

        layer = "top";
        position = "top";
        modules-left = ["custom/menu" "custom/notification" "clock"];
        modules-center = ["niri/workspaces"];
        modules-right = ["group/expand" "bluetooth" "pulseaudio" "custom/endpoint" "network" "battery" "tray"];
        reload_style_on_change = true;

        "niri/workspaces" = {
          format = "{icon}";
          format-icons = {
            active = "";
            default = "";
            empty = "";
          };
          persistent-workspaces."*" = [1 2 3 4 5];
        };

        "pulseaudio" = {
          format = "{icon} {volume}%";
          tooltip = false;
          format-muted = " 󰖁 ";
          on-click = "pamixer -t";
          on-scroll-down = "pamixer -i 1";
          on-scroll-up = "pamixer -d 1";
          scroll-step = 75;
          format-icons = {
            headphone = " ";
            hands-free = " ";
            headset = " ";
            phone = " ";
            portable = " ";
            car = " ";
            default = [" " " " " "];
          };
        };

        "custom/notification" = {
          tooltip = false;
          format = " ";
          on-click = "dunstctl history-pop";
          escape = true;
        };

        clock = {
          format = "{:%I:%M:%S %p} ";
          interval = 1;
          tooltip-format = "<tt>{calendar}</tt>";
          calendar.format.today = "<span color='#fAfBfC'><b>{}</b></span>";
          actions = {
            on-click-right = "shift_down";
            on-click = "shift_up";
          };
        };

        network = {
          format-wifi = " ";
          format-ethernet = " ";
          format-disconnected = " ";
          tooltip-format-disconnected = "Error";
          tooltip-format-wifi = "{essid} ({signalStrength}%) ";
          tooltip-format-ethernet = "{ifname} 🖧";
          on-click = "kitty nmtui";
        };

        bluetooth = {
          format-on = " ";
          format-off = "BT-off";
          format-disabled = "󰂲 ";
          format-connected-battery = "{device_battery_percentage}% 󰂯";
          format-alt = "{device_alias}  ";
          tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\n{device_address}";
          tooltip-format-enumerate-connected-battery = "{device_alias}\n{device_address}\n{device_battery_percentage}%";
          on-click = "blueman-manager";
        };

        battery = {
          interval = 30;
          states = {
            good = 95;
            warning = 30;
            critical = 20;
          };
          format = "{capacity}% {icon}";
          format-charging = "{capacity}% 󰂄";
          format-plugged = "{capacity}% 󰂄 ";
          format-alt = "{time} {icon}";
          format-icons = [
            "󰁻"
            "󰁼"
            "󰁾"
            "󰂀"
            "󰂂"
            "󰁹"
          ];
        };

        "custom/pacman" = {
          format = "󰅢 {}";
          interval = 30;
          exec = "checkupdates | wc -l";
          exec-if = "exit 0";
          on-click = "kitty sudo; echo Done - Press enter to exit; read'; pkill -SIGRTMIN+8 waybar";
          signal = 8;
          tooltip = false;
        };

        "custom/expand" = {
          format = "";
          tooltip = false;
        };

        "custom/endpoint" = {
          format = "|";
          tooltip = false;
        };

        "group/expand" = {
          orientation = "horizontal";
          drawer = {
            transition-duration = 600;
            transition-to-left = true;
            click-to-reveal = true;
          };
          modules = ["custom/expand" "custom/colorpicker" "cpu" "memory" "temperature" "custom/endpoint"];
        };

        "custom/colorpicker" = {
          format = "{}";
          return-type = "json";
          interval = "once";
          exec = "~/.config/waybar/scripts/colorpicker.sh -j";
          on-click = "~/.config/waybar/scripts/colorpicker.sh";
          signal = 1;
        };

        cpu.format = "󰻠 ";
        memory.format = " ";
        temperature = {
          critical-threshold = 80;
          format = " ";
        };

        tray = {
          icon-size = 14;
          spacing = 10;
        };

        style = ''
          @import url('../../.cache/wal/colors-waybar.css');

          * {
              font-size: 15px;
              font-family: "CodeNewRoman Nerd Font Propo";
          }
          window#waybar {
              margin-bottom: 2px;
              margin-top: 2px;
              padding-bottom:0px;
              padding-top: 0px;
              all: unset;
          }
          .modules-left, .modules-center, .modules-right {
              padding: 10px;
              margin: 1px 0 1px 5px;
              border-radius: 5px;
              background: alpha(@background, .6);
              box-shadow: 0px 0px 2px rgba(0, 0, 0, .6);
          }
          .modules-center { margin-left: 0; margin-right: 0; }
          .modules-right { margin-left: 0; margin-right: 10px; }

          tooltip {
              background: @background;
              color: @color7;
          }

          #clock:hover, #custom-pacman:hover, #custom-notification:hover,
          #bluetooth:hover, #network:hover, #battery:hover, #cpu:hover,
          #memory:hover, #temperature:hover {
              transition: all .3s ease;
              color: @color9;
          }
          #custom-notification, #clock, #custom-pacman, #bluetooth, #network,
          #battery, #cpu, #memory, #temperature, #group-expand, #tray {
              padding: 0px 5px;
              transition: all .3s ease;
              color: @color7;
          }
          #battery.charging { color: #26A65B; }
          #battery.warning:not(.charging) { color: #ffbe61; }
          #battery.critical:not(.charging) {
              color: #f533c;
              animation-name: blink;
              animation-duration: 0.5s;
              animation-timing-function: linear;
              animation-iteration-count: infinite;
              animation-direction: alternate;
          }

          #custom-expand {
              padding: 0px 5px;
              color: alpha(@foreground, .2);
              text-shadow: 0px 0px 2px rgba(0, 0, 0, .7);
              transition: all .3s ease;
          }
          #custom-expand:hover {
              color: rgba(255,255,255,.2);
              text-shadow: 0px 0px 2px rgba(255, 255, 255, .5);
          }

          #workspaces {
              padding: 0px 5px;
          }
          #workspaces button {
              all: unset;
              padding: 0px 5px;
              color: alpha(@color9, .4);
              transition: all .2s ease;
          }
          #workspaces button:hover {
              color: rgba(0,0,0,0);
              text-shadow: 0px 0px 1.5px rgba(0, 0, 0, .5);
              transition: all 1s ease;
          }
          #workspaces button.active {
              color: @color9;
              text-shadow: 0px 0px 2px rgba(0, 0, 0, .5);
          }
          #workspaces button.empty {
              color: rgba(0,0,0,0);
            text-shadow: 0px 0px 1.5px rgba(0, 0, 0, .2);
          }
          #workspaces button.empty:hover, #workspaces button.empty.active {
              text-shadow: 0px 0px 1.5px rgba(0, 0, 0, .5);
              transition: all 1s ease;
          }

          #custom-endpoint {
              color: transparent;
              text-shadow: 0px 0px 1.5px rgba(0, 0, 0, 1);
          }
          #tray menu *, #tray menu separator {
              padding: 0px 5px;
              transition: all .3s ease;
          }
        '';
      }
    ];
  };

  home.file.".config/waybar/scripts/colourpicker.sh" = {
    text = ''
          #!/usr/bin/env bash
      check() {
        command -v "$1" 1>/dev/null
      }



      loc="$HOME/.cache/colorpicker"
      [ -d "$loc" ] || mkdir -p "$loc"
      [ -f "$loc/colors" ] || touch "$loc/colors"

      limit=10

      [[ $# -eq 1 && $1 = "-l" ]] && {
        cat "$loc/colors"
        exit
      }

      [[ $# -eq 1 && $1 = "-j" ]] && {
        text="$(head -n 1 "$loc/colors")"

        mapfile -t allcolors < <(tail -n +2 "$loc/colors")
        # allcolors=($(tail -n +2 "$loc/colors"))
        tooltip="<b>   COLORS</b>\n\n"

        tooltip+="-> <b>$text</b>  <span color='$text'></span>  \n"
        for i in ''${allcolors[@]}"; do
          tooltip+="   <b>$i</b>  <span color='$i'></span>  \n"
        done

        cat <<EOF
      { "text":"<span color='$text'></span>", "tooltip":"$tooltip"}
      EOF

        exit
      }

      check hyprpicker || {
        notify "hyprpicker is not installed"
        exit
      }
      killall -q hyprpicker
      color=$(hyprpicker)

      check wl-copy && {
        echo "$color" | sed -z 's/\n//g' | wl-copy
      }

      prevColors=$(head -n $((limit - 1)) "$loc/colors")
      echo "$color" >"$loc/colors"
      echo "$prevColors" >>"$loc/colors"
      sed -i '/^$/d' "$loc/colors"
      source ~/.cache/wal/colors.sh && notify-send "Color Picker" "This color has been selected: $color" -i $wallpaper
      pkill -RTMIN+1 waybar
    '';
    executable = true;
  };

  home.file.".config/waybar/scripts/select.sh" = {
    text = ''
          #!/bin/bash
      WAYBAR_DIR="$HOME/.config/waybar"
      STYLECSS="$WAYBAR_DIR/style.css"
      CONFIG="$WAYBAR_DIR/config"
      ASSETS="$WAYBAR_DIR/assets"
      THEMES="$WAYBAR_DIR/themes"
      menu() {
          find ''${ASSETS}" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) | awk '{print "img:"$0}'
      }
      main() {
          choice=$(menu | wofi -c ~/.config/wofi/waybar -s ~/.config/wofi/style-waybar.css --show dmenu --prompt "  Select Waybar (Scroll with Arrows)" -n)
          selected_wallpaper=$(echo "$choice" | sed 's/^img://')
          echo $selected_wallpaper
          if [[ "$selected_wallpaper" == "$ASSETS/experimental.png" ]]; then
              cat $THEMES/experimental/style-experimental.css > $STYLECSS
              cat $THEMES/experimental/config-experimental > $CONFIG
              pkill waybar && waybar
          elif [[ "$selected_wallpaper" == "$ASSETS/main.png" ]]; then
              cat $THEMES/default/style-default.css > $STYLECSS
              cat $THEMES/default/config-default > $CONFIG
              pkill waybar && waybar
          elif [[ "$selected_wallpaper" == "$ASSETS/line.png" ]]; then
              cat $THEMES/line/style-line.css > $STYLECSS
              cat $THEMES/line/config-line > $CONFIG
              pkill waybar && waybar
          elif [[ "$selected_wallpaper" == "$ASSETS/zen.png" ]]; then
              cat $THEMES/zen/style-zen.css > $STYLECSS
              cat $THEMES/zen/config-zen > $CONFIG
              pkill waybar && waybar
          fi

      }
      main '';
    executable = true;
  };

  home.file.".config/waybar/scripts/refresh.sh" = {
    text = ''
          #!/bin/bash

      # Check if waybar is running
      if pgrep -x "waybar" > /dev/null; then
          # If running, kill the waybar process
          pkill -x "waybar"
      else
          # If not running, start waybar
          waybar &
      fi'';
    executable = true;
  };
}
/*
programs.waybar = {
  enable = true;
  systemd.enable = true;
  settings = {
    mainBar = {
      layer = "bottom";
      position = "top";
      height = 30;
      modules-left = ["niri/workspaces" "niri/mode"];
      modules-center = ["niri/window"];
      modules-right = [
        "tray"
        "custom/spotify"
        "custom/weather"
        "custom/mail"
        "custom/storage"
        "backlight"
        "pulseaudio"
        "network"
        "idle_inhibitor"
        "battery"
        "clock"
      ];

      "niri/mode" = {
        format = " {}";
      };

      "niri/workspaces" = {
        format = "{name}";
        "disable-scroll" = true;
      };

      "niri/window" = {
        "max-length" = 80;
        tooltip = false;
      };

      clock = {
        format = "{:%a %d %b %H:%M}";
        tooltip = false;
      };

      battery = {
        format = "{capacity}% {icon}";
        "format-alt" = "{time} {icon}";
        "format-icons" = ["" "" "" "" ""];
        "format-charging" = "{capacity}% ";
        interval = 30;
        states = {
          warning = 25;
          critical = 10;
        };
        tooltip = false;
      };

      network = {
        format = "{icon}";
        "format-alt" = "{ipaddr}/{cidr} {icon}";
        "format-alt-click" = "click-right";
        "format-icons" = {
          wifi = ["" "" ""];
          ethernet = [""];
          disconnected = [""];
        };
        "on-click" = "termite -e nmtui";
        tooltip = false;
      };

      pulseaudio = {
        format = "{icon}";
        "format-alt" = "{volume} {icon}";
        "format-alt-click" = "click-right";
        "format-muted" = "";
        "format-icons" = {
          phone = [" " " " " " " "];
          default = ["" "" "" ""];
        };
        "scroll-step" = 10;
        "on-click" = "pavucontrol";
        tooltip = false;
      };

      "custom/spotify" = {
        interval = 1;
        "return-type" = "json";
        exec = "~/.config/waybar/modules/spotify.sh";
        "exec-if" = "pgrep spotify";
        escape = true;
      };

      "custom/storage" = {
        format = "{} ";
        "format-alt" = "{percentage}% ";
        "format-alt-click" = "click-right";
        "return-type" = "json";
        interval = 60;
        exec = "~/.config/waybar/modules/storage.sh";
      };

      backlight = {
        format = "{icon}";
        "format-alt" = "{percent}% {icon}";
        "format-alt-click" = "click-right";
        "format-icons" = ["" ""];
        "on-scroll-down" = "light -A 1";
        "on-scroll-up" = "light -U 1";
      };

      "custom/weather" = {
        format = "{}";
        "format-alt" = "{alt}: {}";
        "format-alt-click" = "click-right";
        interval = 1800;
        "return-type" = "json";
        exec = "~/.config/waybar/modules/weather.sh";
        "exec-if" = "ping wttr.in -c1";
      };

      idle_inhibitor = {
        format = "{icon}";
        "format-icons" = {
          activated = "";
          deactivated = "";
        };
        tooltip = false;
      };

      "custom/mail" = {
        format = "";
        "format-alt" = "{alt} ";
        "format-alt-click" = "click-right";
        interval = 60;
        "return-type" = "json";
        exec = "~/.config/waybar/modules/mail.py";
        tooltip = false;
      };

      "custom/test" = {
        format = "{}";
        exec = "/tmp/test blub";
        param = "blah";
        interval = 5;
      };

      tray = {
        "icon-size" = 18;
      };
    };
  };
  style = ''
    * {
        border: none;
        border-radius: 0;
        font-family: Sans;
        font-size: 15px;
        box-shadow: none;
        text-shadow: none;
        transition-duration: 0s;
    }

    window {
        color: rgba(217, 216, 216, 1);
        background: rgba(35, 31, 32, 0.00);
    }

    window#waybar.solo {
        color: rgba(217, 216, 216, 1);
        background: rgba(35, 31, 32, 0.85);
    }

    #workspaces {
        margin: 0 5px;
    }

    #workspaces button {
        padding: 0 5px;
        color: rgba(217, 216, 216, 0.4);
    }

    #workspaces button.visible {
        color: rgba(217, 216, 216, 1);
    }

    #workspaces button.focused {
        border-top: 3px solid rgba(217, 216, 216, 1);
        border-bottom: 3px solid rgba(217, 216, 216, 0);
    }

    #workspaces button.urgent {
        color: rgba(238, 46, 36, 1);
    }

    #mode, #battery, #cpu, #memory, #network, #pulseaudio, #idle_inhibitor, #backlight, #custom-storage, #custom-spotify, #custom-weather, #custom-mail {
        margin: 0px 6px 0px 10px;
        min-width: 25px;
    }

    #clock {
        margin: 0px 16px 0px 10px;
        min-width: 140px;
    }

    #battery.warning {
       color: rgba(255, 210, 4, 1);
    }

    #battery.critical {
        color: rgba(238, 46, 36, 1);
    }

    #battery.charging {
        color: rgba(217, 216, 216, 1);
    }

    #custom-storage.warning {
        color: rgba(255, 210, 4, 1);
    }

    #custom-storage.critical {
        color: rgba(238, 46, 36, 1);
    }
  '';
};
*/

