function __skim_cd --description "run fzf to find a directory to `cd` into"
  set directory (find . -type d | fzf --reverse --height=15)
  if test $status -eq 0
    cd $directory
  end
end
