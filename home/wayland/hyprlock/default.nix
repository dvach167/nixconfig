{
  config,
  pkgs,
  ...
}: let
  hyprDir = "~/.config/hypr";
  infoScript = "${hyprDir}/bin/infonlock.sh";
in {
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        grace = 1;
        disable_loading_bar = false;
        hide_cursor = true;
        ignore_empty_input = true;
        text_trim = true;
      };

      auth = {
        "fingerprint:enabled" = true;
      };

      background = {
        monitor = "";
        #path = "screenshot";
        blur_passes = 2;
        blur_size = 7;
        contrast = 0.8916;
        brightness = 0.7172;
        vibrancy = 0.1696;
        vibrancy_darkness = 0;
      };

      #image = [
      # {
      #monitor="";
      #halign="center";
      #path="/home/dom/Downloads/";
      #position="0, 50";
      #valign="center";
      #}
      #];

      /*
        input-field = [
        {
          monitor = "";
          size = "350,75";
          #check_color = "rgb(30, 107, 204)";
          #dots_center = "true";
          #dots_size = "0.200000";
          #dots_spacing = "0.350000";
          fade_on_empty = "false";
          #font_color = "rgb(111, 45, 104)";
          halign = "center";
          hide_input = "false";
          inner_color = "rgba(0, 0, 0, 0.2)";
          outer_color = "rgba(0, 0, 0, 0)";
          outline_thickness = "2";
          placeholder_text = ''<i><span foreground="##cdd6f4">Input Password...</span></i>'';
          position = "0, -100";
          rounding = "-1";
          valign = "center";
        }
      ];
      */

      label = [
        {
          monitor = "";
          #color = "rgb(242, 243, 244)";
          font_family = "SF Pro Text";
          font_size = "140";
          halign = "center";
          position = "0, 300";
          text = ''$TIME'';
          valign = "center";
        }
        {
          monitor = "";
          #color = "rgb(242, 243, 244)";
          font_family = "SF Pro Text";
          font_size = "25";
          halign = "center";
          position = "0, 410";
          text = ''cmd[update:43200000] echo "$(date +"%A, %d %B")"'';
          valign = "center";
        }

        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(~/.config/Scripts/battery-status)‎"'';
          #color = "rgba(242, 243, 244, 0.75)";
          font_size = "30";
          #"19";
          font_family = "SF Pro Display Bold";
          position = "-93, 920";
          halign = "right";
          valign = "center";
        }

        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(~/.config/Scripts/network-status)‎"'';
          #color = "rgba(242, 243, 244, 0.75)";
          font_size = "26";
          #"16"
          font_family = "SF Pro Display Bold";
          position = "-35, 920";
          halign = "right";
          valign = "center";
        }
      ];
    };
  };
}
