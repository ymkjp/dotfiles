#exec i3 >> /var/log/i3/$(date +'%s').log 2&>1
#export GDK_BACKEND=x11
#exec gnome-session
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap
#	export XDG_CURRENT_DESKTOP=GNOME-Classic:GNOME
#	export GNOME_SHELL_SESSION_MODE=classic
#	exec gnome-session --session=gnome-classic
