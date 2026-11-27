#!/usr/bin/env bash
# Current moon phase as a Nerd Font weather glyph (nf-weather-moon_*).

ref=947182440        # known new moon: 2000-01-06 18:14 UTC
syn=2551443          # synodic month in seconds (29.53 d)
now=$(date +%s)
age=$(((now - ref) % syn))
idx=$(((age * 28 + syn / 2) / syn % 28))
days=$(awk "BEGIN{printf \"%.1f\", $age/86400}")

names=("New Moon" "Waxing Crescent" "First Quarter" "Waxing Gibbous"
       "Full Moon" "Waning Gibbous" "Last Quarter" "Waning Crescent")
case $idx in
  0) n=0 ;; [1-6]) n=1 ;; 7) n=2 ;; 8|9|1[0-3]) n=3 ;;
  14) n=4 ;; 1[5-9]|20) n=5 ;; 21) n=6 ;; *) n=7 ;;
esac

glyph=$(printf "\\u$(printf '%x' $((0xE38D + idx)))")
printf '{"text":"%s","tooltip":"%s · day %s of 29.5"}\n' "$glyph" "${names[n]}" "$days"
