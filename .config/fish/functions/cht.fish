function cht
    curl -s https://cheat.sh/:list | fzf --preview 'curl -s https://cheat.sh/{}' --height=100%
end
