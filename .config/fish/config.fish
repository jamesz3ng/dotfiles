
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /opt/anaconda3/bin/conda
    eval /opt/anaconda3/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/opt/anaconda3/etc/fish/conf.d/conda.fish"
        . "/opt/anaconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/opt/anaconda3/bin" $PATH
    end
end
# <<< conda initialize <<<

set -gx PATH /usr/local/bin /usr/local/sbin $PATH; eval (/opt/homebrew/bin/brew shellenv) 2>/dev/null; or eval (/usr/local/bin/brew shellenv) 2>/dev/null

starship init fish | source

fzf --fish | source
zoxide init fish | source
set -x FZF_DEFAULT_COMMAND 'fd --type f --exclude .git'
set -x FZF_ALT_C_COMMAND 'fd --type d --exclude .git'
set -x FZF_CTRL_T_COMMAND 'fd --type f --exclude .git'
