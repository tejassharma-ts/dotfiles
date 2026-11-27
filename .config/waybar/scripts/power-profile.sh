#!/usr/bin/env bash
# TLP power profile indicator / switcher.
#   no args : print waybar JSON for the current profile
#   next    : cycle power-saver -> balanced -> performance
#   prev    : cycle the other way

SIGNAL=8
profiles=(power-saver balanced performance)

current() {
  local m
  m=$(tlp-stat -m 2>/dev/null)
  m=${m%%/*}
  [[ -z $m ]] && m=$(cat /sys/firmware/acpi/platform_profile 2>/dev/null)
  case $m in
    performance) echo performance ;;
    power-saver | low-power) echo power-saver ;;
    *) echo balanced ;;
  esac
}

switch() {
  local cur idx n next
  cur=$(current)
  n=${#profiles[@]}
  for i in "${!profiles[@]}"; do [[ ${profiles[i]} == "$cur" ]] && idx=$i; done
  if [[ $1 == prev ]]; then next=${profiles[(idx - 1 + n) % n]}
  else next=${profiles[(idx + 1) % n]}; fi

  if ! sudo -n /usr/bin/tlp "$next" >/dev/null 2>&1; then
    pkexec /usr/bin/tlp "$next" >/dev/null 2>&1 || {
      notify-send -a waybar "Power profile" "Could not switch to $next" 2>/dev/null
      exit 1
    }
  fi
  pkill -RTMIN+$SIGNAL -x waybar
}

case $1 in
  next | prev) switch "$1"; exit ;;
esac

p=$(current)
case $p in
  performance) icon="<span color='#e78a4e'></span>"; label="Performance" ;;
  power-saver) icon="<span color='#a9b665'></span>"; label="Power Saver" ;;
  *)           icon="<span color='#7daea3'></span>"; label="Balanced" ;;
esac

acpi=$(cat /sys/firmware/acpi/platform_profile 2>/dev/null)
epp=$(cat /sys/devices/system/cpu/cpu0/cpufreq/energy_performance_preference 2>/dev/null)
gov=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor 2>/dev/null)

tooltip="Power profile: ${label}\nPlatform: ${acpi:--}\nEPP: ${epp:--}\nGovernor: ${gov:--}\n\nClick: next · Right-click: previous"
printf '{"text":"%s  %s","alt":"%s","class":"%s","tooltip":"%s"}\n' "$icon" "$label" "$p" "$p" "$tooltip"
