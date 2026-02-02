CHOICE=$(printf "Power off\nReboot\nQuit Sway" | rofi -dmenu)

case "$CHOICE" in
  "Power off")
    poweroff
    ;;
  "Reboot")
    reboot
    ;;
  "Quit Sway")
    swaymsg exit
    ;;
esac