function jump
  set -l dir (fd --type d --hidden --follow --exclude .git . $HOME | fzf)
  if test -n "$dir"
    cd "$dir"
  end
end