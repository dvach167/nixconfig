{
  config,
  pkgs,
  ...
}: {
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;

    settings = [
      {
        layer = "top";
        height = 10;
        modules-left = ["custom/arch" "hyprland/workspaces" "memory"];
        modules-center = ["custom/playerctl"];
        modules-right = ["backlight" "pulseaudio" "battery" "network" "clock" "tray" "cpu" "temperature"];
        "custom/arch" = {
          format = "  ";
          on-click = "sh /home/dom/.config/hypr/scripts/exec_wofi application_launcher";
        };
        "custom/playerctl" = {
          format = "{icon}  <span>{}</span>";
          return-type = "json";
          max-length = 55;
          exec = "playerctl -a metadata --format '{\"text\": \"  {{markup_escape(title)}}\", \"tooltip\": \"{{playerName}} : {{markup_escape(title)}}\", \"alt\": \"{{status}}\", \"class\": \"{{status}}\"}' -F";
          on-click-middle = "playerctl previous";
          on-click = "playerctl play-pause";
          on-click-right = "playerctl next";
          format-icons = {
            Paused = "<span foreground='#bb9af7'></span>";
            Playing = "<span foreground='#bb9af7'></span>";
          };
        };
        "hyprland/workspaces" = {
          format = "{icon}";
          on-click = "activate";
          all-outputs = true;
          persistent_workspaces = {
            "1" = [];
            "2" = [];
            "3" = [];
            "4" = [];
            "5" = [];
            "6" = [];
            "7" = [];
            "8" = [];
            "9" = [];
            "10" = [];
          };
          format-icons = {
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            "6" = "6";
            "7" = "7";
            "8" = "8";
            "9" = "9";
            "10" = "1〇";
          };
        };
        clock = {
          format = "<span color='#b69bf1'> </span>{:%H:%M}";
          format-alt = "<span foreground='#b69bf1'> </span><span>{:%I:%M %p %a %d}</span>";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };
        battery = {
          format = "<span color='#a8cd76'>{icon}</span> {capacity}%";
          format-icons = ["" "" "" "" "" "" "" "" "" "" ""];
          format-charging = "<span color='#a8cd76'></span> {capacity}%";
        };
        network = {
          interface = "wlo1";
          format = "{ifname}";
          format-wifi = "<span color='#90cdfa'> </span>{essid}({signalStrength}%)";
          format-ethernet = "{ipaddr}/{cidr} ";
          format-disconnected = "<span color='#ff005f'>󰖪 </span>No Network";
          on-click = "kitty nmtui";
        };
        tray = {
          icon-size = 20;
          reverse-direction = true;
          spacing = 6;
        };
        cpu = {
          format = "<span foreground='#ff005f'></span>  {usage}%";
        };
        temperature = {
          critical-threshold = 80;
          format = "<span foreground='#5d73ca'></span> {temperatureC}°C";
        };
      }
    ];

    style = ''
      * {
        border: none;
        font-family: 'JetBrainsMono Nerd Font', 'Symbols Only';
        font-size: 16px;
        font-feature-settings: '"zero", "ss01", "ss02", "ss03", "ss04", "ss05", "cv31"';
        min-height: 30px;
      }
      window#waybar {
        background: transparent;
      }
      #custom-arch, #workspaces {
        border-radius: 10px;
        background-color: #191a24;
        color: #c0caf5;
        margin-top: 15px;
        margin-right: 15px;
        padding-top: 1px;
        padding-left: 10px;
        padding-right: 10px;
      }
      #custom-arch {
        font-size: 20px;
        margin-left: 15px;
      }
      #workspaces button {
        background: #191a24;
        color: #c0caf5;
      }
      #workspaces button.active {
        color: #2ac3de;
      }
      #clock, #backlight, #custom-cava, #temperature, #cpu, #pulseaudio, #network, #battery, #tray, #memory, #custom-playerctl {
        border-radius: 10px;
        background-color: #191a24;
        color: #c0caf5;
        margin-top: 15px;
        padding-left: 9px;
        padding-right: 9px;
        margin-right: 15px;
      }
      @keyframes blink {
        to {
          background-color: #ffffff;
          color: black;
        }
      }
      #battery.warning:not(.charging) {
        background: #f38ba8;
        color: white;
        animation-name: blink;
        animation
      }'';
  };
}
