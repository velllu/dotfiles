CHOICE=$(printf "Power off\nReboot\nQuit BSPWM" | rofi -dmenu)

case "$CHOICE" in
  "Power off")
    poweroff
    ;;
  "Reboot")
    reboot
    ;;
  "Quit BSPWM")
    bspc quit
    ;;
esac