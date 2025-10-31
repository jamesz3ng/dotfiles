function zz
    set -l dir (
        zoxide query --list --score |
        fzf --height 40% --layout reverse --info inline \
            --nth 2.. --tac --no-sort --query "$argv" \
            --bind 'enter:become:echo {2..}'
    )
    and cd "$dir"
end
