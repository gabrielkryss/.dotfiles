# zellij-attach
function za
  if set -l sessions (zellij list-sessions | rg -o '^[^\n]+')
    set -l selected_session (zellij list-sessions | string split -m 1 '\n' | fzf)
    if test -n "$selected_session"
      zellij attach "$selected_session"
    end
  end
end