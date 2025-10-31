function ff
    aerospace list-windows --all | fzf --bind 'enter:execute(aerospace focus --window-id {1})+abort'
end
