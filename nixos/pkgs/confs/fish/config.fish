# Fix some utf-8 errors
set -gx LC_ALL en_CA.UTF-8

# gnome-keyring insists on setting this to itself, even if ssh support is disabled
set -x SSH_AUTH_SOCK "/run/user/1000/gnupg/S.gpg-agent.ssh"

# tuuuuuuuurbofish!
set fish_greeting 'Welcome to the '(set_color FA1100)'::<>' (set_color normal)'...'

eval (direnv hook fish)