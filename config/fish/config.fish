if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -gx EDITOR nvim
starship init fish | source
export PATH="/home/davisc/miniconda3/bin:$PATH"
export FZF_DEFAULT_COMMAND="fd --type f --strip-cwd-prefix"

alias nF='nvim $(fd --type f -H | fzf )'
alias nD='cd $(fd --type d -H | fzf) && nvim -c"Telescope fd"'
alias nf='nvim $(fd --type f -H --strip-cwd-prefix | fzf )'
alias nd='cd $(fd --type d -H --strip-cwd-prefix | fzf) && nvim -c"Telescope fd"'

alias nl='nvim -c":e#<1"'

alias ca='conda activate'
alias cenv='conda env'

alias ls='eza -a --icons'
alias ll='eza -al --icons'
alias lt='eza -a --tree --level=1 --icons'

abbr n nvim
abbr rm rm -rf
abbr cp cp -r
