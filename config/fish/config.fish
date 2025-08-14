if status is-interactive
    # Commands to run in interactive sessions can go here
end
# if test (tty) = "/dev/tty1"
#      sway
# end
set -gx EDITOR nvim
set -gx LC_ALL en_US.UTF-8
set -gx LANG en_US.UTF-8
#
function fish_hybrid_key_bindings --description \
    "Vi-style bindings that inherit emacs-style bindings in all modes"
    for mode in default insert visual
        fish_default_key_bindings -M $mode
    end
    fish_vi_key_bindings --no-erase
end

set -g fish_key_bindings fish_hybrid_key_bindings
# set --universal tide_right_prompt_items 
export FZF_DEFAULT_COMMAND="fd --type f --strip-cwd-prefix"
export MOZ_ENABLE_WAYLAND=1
export GDK_BACKEND=wayland
# export FZF_DEFAULT_OPTS=" \
# --color=bg+:#202020,bg:#151515,spinner:#ffafaf,hl:#ff8700 \
# --color=fg:#dddddd,header:#ffaf5f,info:#ff8700,pointer:#ffafaf \
# --color=marker:#ff5f87,fg+:#c6b6ee,prompt:#ff8700,hl+:#ff8700 \
# --color=border:#151515 \
# --multi"
alias nl='nvim -c":e#<1"'
function nvim_find_file
    set file $(fd fi --type f | fzf)
    if [ -n "$file" ]
        nvim $file
    end
end
alias nf nvim_find_file

function find_dir
    set dir $(fd fi --type d | fzf)
    if [ -n "$dir" ]
        cd $dir
    end
end
alias cdd find_dir

# Git easily update everything, useful for todo list or solo projects
function git_update
    git pull
    git add .
    git commit -m '`date`'
    git push
end
alias gU git_update

function _parent_dirs --on-variable PWD
    set -g _parent_dirs (string escape (
        for dir in (string split / -- $PWD)
            set -la parts $dir
            string join / -- $parts
        end))
end

# function fish_prompt
#     set -l last_status $status # Get status of last command (before any commands by prompt)
#     _parent_dirs
#     echo $_parent_dirs
#
#     if not set -q VIRTUAL_ENV_DISABLE_PROMPT
#         set -g VIRTUAL_ENV_DISABLE_PROMPT true
#     end
#     # string join '' -- (set_color green)  () (set_color normal) $stat (set color white) (fish_vcs_prompt) '> ' 
#
#     # set_color green
#     printf '%s' (prompt_pwd --full-length-dirs 2)
#     set_color normal
#
#
#
#     if test -n "$VIRTUAL_ENV"
#         set_color -o
#         printf "  %s" (path basename $VIRTUAL_ENV_PROMPT)
#         if command -q python3
#             python3 --version | string match -qr "(?<v>[\d.]+)"
#         else
#             python --version | string match -qr "(?<v>[\d.]+)"
#         end
#         string match -qr "^.*/(?<dir>.*)/(?<base>.*)" $VIRTUAL_ENV
#         if test "$dir" = virtualenvs
#             string match -qr "(?<base>.*)-.*" $base
#         end
#         if path is .python-version Pipfile __init__.py pyproject.toml requirements.txt setup.py
#             if command -q python3
#                 python3 --version | string match -qr "(?<v>[\d.]+)"
#             else
#                 python --version | string match -qr "(?<v>[\d.]+)"
#             end
#         end
#
#         printf '[%s]' $v 
#         set_color normal
#     end
#
#     if path is $_parent_dirs/Cargo.toml
#         rustc --version | string match -qr "(?<v>[\d.]+)"
#         printf '%s' $v
#     end
#
#     printf '%s' (fish_git_prompt)
#
#     # Prompt status only if it's not 0
#     if test $last_status -ne 0
#         set_color red
#         printf '%s' [$last_status]
#     end
#
#     set_color normal
#
#     printf '> '
#
# end

function nvim_dir
    set dir $(fd fi --type d | fzf)
    if [ -n "$dir" ]
        cd $dir
    end
end
alias nd nvim_dir

alias ls='eza -a  '
alias ll='eza -al  '
alias lt='eza -a --tree --level=1 '
# alias ls='eza -a --icons '
# alias ll='eza -al --icons '
# alias lt='eza -a --tree --level=1 --icons '
alias ...="cd ../.."
# alias ls='eza -a --icons --colour never'
# alias ll='eza -al --icons --colour never'
# alias lt='eza -a --tree --level=1 --icons --colour never'
# alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

function agenda
    cd ~/agenda/
    git pull
    nvim .
end
function update-sys
    paru -Syu
    rustup update
    cargo install-update -a
end
abbr pau update-sys
abbr p paru
abbr par paru -R
abbr pas paru -S

abbr n nvim
abbr rm rm -rf
abbr cp cp -r

abbr crr cargo run
abbr crt cargo test
abbr crb cargo build
abbr crc cargo check

abbr lg lazygit

abbr gP git push
abbr gp git pull
abbr ga git add
abbr gaa git add .
abbr gc git commit
abbr gb git branch
abbr gst git stash

abbr lg lazygit

abbr ur uv run
abbr un uv run nvim
abbr ua uv add
abbr pip uv pip
abbr upi uv pip install
abbr uvv uv venv

abbr ape source .venv/bin/activate.fish
abbr py python

alias hx=helix
function zathura_nohup -a doc
    nohup zathura $doc &
end
alias zt=zathura_nohup

bind -M insert ctrl-o fish_commandline_append execute
bind -M default ctrl-o fish_commandline_append execute
bind -M visual ctrl-o fish_commandline_append execute

abbr zl zellij
function zellij-fzf
    set session $(zellij ls | sed 's/\x1b\[[0-9;]*m//g' | fzf)
    if [ -n "$session" ]
        zellij attach (string split ' ' -- $session)[1]
    end
end
alias zls=zellij-fzf
# Remove ANSI escape codes and search zellij sessions
# abbr zs zellij
# starship init fish | source
