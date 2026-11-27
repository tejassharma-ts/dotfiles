#!/usr/bin/env bash
# Plays a sound when the charger (AC) is plugged in, another when unplugged.
SOUND="$HOME/.local/share/sounds/xp-startup-fast.mp3"
UNPLUG_SOUND="$HOME/.local/share/sounds/xp-error.mp3"
AC=/sys/class/power_supply/AC/online
prev=$(cat "$AC")
udevadm monitor --udev --subsystem-match=power_supply | while read -r _; do
  cur=$(cat "$AC")
  if [[ "$prev" == 0 && "$cur" == 1 ]]; then
    mpv --no-video --really-quiet "$SOUND" &
  elif [[ "$prev" == 1 && "$cur" == 0 ]]; then
    mpv --no-video --really-quiet "$UNPLUG_SOUND" &
  fi
  prev=$cur
done
