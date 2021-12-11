
#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Launch bar1 and example
polybar example 2>&1 | tee -a /tmp/polyexample.log & disown

echo "Bars launched..."
