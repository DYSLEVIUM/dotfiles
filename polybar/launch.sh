killall -q polybar

# wait until the process is down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# launch bar1 and bar2
polybar example 2>&1 | tee -a /tmp/polybar1.log & disown
