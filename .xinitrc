# Load Xresources
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

# Activate numlock
numlockx&

# Turn off bell
xset -b

# Standby / Suspend / Off (seconds)
# Handled by locker, so disable all
xset dpms 0 0 0
xset s off # Disable screen blanking

# Background
feh --bg-fill ~/code/images/wallpapers/spots_shadows_background.png

# Start composter
compton -b

# Provide display to systemd
dbus-update-activation-environment --systemd DISPLAY

exec i3
