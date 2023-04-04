# Fix some utf-8 errors
set -gx LC_ALL en_CA.UTF-8

fish_add_path -g ~/.cargo/bin
fish_add_path -g ~/bin
   

# tuuuuuuuurbofish!
set fish_greeting 'Welcome to the '(set_color FA1100)'::<>' (set_color normal)'...'

starship init fish | source