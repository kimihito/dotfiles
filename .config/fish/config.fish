jump shell fish | source

fzf --fish | source

starship init fish | source

if status is-interactive
    eval (zellij setup --generate-auto-start fish | string collect)
end

if status is-interactive
  mise activate fish | source
else
  mise activate fish --shims | source
end
