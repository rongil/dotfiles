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
feh --bg-fill ~/.config/i3/img/wallpapers/dragon_red.jpg

# Start composter
compton -b

# Start ssh agent
eval $(ssh-agent)

# Start gnome-keyring daemon
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets)
export SSH_AUTH_SOCK

exec i3
