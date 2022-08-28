function __fancy_history --description "history(1) but cool!"
  set __queried_cmd (history | fzf --height=15 --reverse)
  commandline -t $__queried_cmd
  commandline -f repaint
end
