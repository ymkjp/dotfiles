# https://wiki.archlinux.org/index.php/keyboard_backlight
setKbdLight () {
  if [[ -x "$(command -v dbus-send)" ]]; then
    dbus-send --system --type=method_call \
        --dest="org.freedesktop.UPower" "/org/freedesktop/UPower/KbdBacklight" "org.freedesktop.UPower.KbdBacklight.SetBrightness" int32:${1-0}
  fi
}

setKbdLight 1

alias pbcopy='copyq copy -'
alias open='xdg-open'

[[ -r "/usr/share/z/z.sh" ]] && . /usr/share/z/z.sh
