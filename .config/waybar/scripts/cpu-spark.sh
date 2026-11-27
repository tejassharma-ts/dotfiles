#!/usr/bin/env bash
# Rolling CPU usage sparkline: ▁▂▃▄▅▆▇█ over the last N samples.

N=8
state="${XDG_RUNTIME_DIR:-/tmp}/waybar-cpu-spark"
bars=(▁ ▂ ▃ ▄ ▅ ▆ ▇ █)

read -r _ u n s i w q sq st _ < /proc/stat
idle=$((i + w))
total=$((u + n + s + i + w + q + sq + st))

prev_total=0 prev_idle=0 hist=""
[[ -f "$state" ]] && read -r prev_total prev_idle hist < "$state"

dt=$((total - prev_total))
di=$((idle - prev_idle))
if ((prev_total > 0 && dt > 0)); then
  usage=$(((100 * (dt - di)) / dt))
else
  usage=0
fi

hist="$hist,$usage"
hist="${hist#,}"
IFS=',' read -ra arr <<< "$hist"
((${#arr[@]} > N)) && arr=("${arr[@]: -N}")
hist=$(IFS=','; echo "${arr[*]}")
echo "$total $idle $hist" > "$state"

spark=""
for v in "${arr[@]}"; do
  idx=$((v * 8 / 101))
  spark+="${bars[idx]}"
done

class="normal"
((usage >= 60)) && class="warning"
((usage >= 85)) && class="critical"

load=$(cut -d' ' -f1-3 /proc/loadavg)
printf '{"text":"%s %s%%","tooltip":"CPU %s%%\\nLoad: %s","class":"%s"}\n' \
  "$spark" "$usage" "$usage" "$load" "$class"
