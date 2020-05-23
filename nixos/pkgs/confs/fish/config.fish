# Fix some utf-8 errors
set -x LC_ALL en_US.utf8

# Make git use emacs
set -x EDITOR kak

# gnome-keyring insists on setting this to itself, even if ssh support is disabled
set -x SSH_AUTH_SOCK "/run/user/1000/gnupg/S.gpg-agent.ssh"

# Better nix-shell support!
any-nix-shell fish --info-right | source
 
# tuuuuuuuurbofish!
set fish_greeting 'Welcome to the '(set_color FA1100)'::<>' (set_color normal)'...'

# python virtualenvwrapper
set -g -x WORKON_HOME ~/virtualenvs

eval (direnv hook fish)
starship init fish | source
