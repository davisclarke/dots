if status is-interactive
    # Commands to run in interactive sessions can go here
end
if test (tty) = "/dev/tty1"
     sway
end
set -gx EDITOR nvim
set --universal tide_character_color white
set --universal tide_pwd_color_dirs white
set --universal tide_pwd_color_dirs white
set --universal tide_pwd_color_anchors white
set --universal tide_pwd_color_anchors white

# set --universal tide_right_prompt_items 
export FZF_DEFAULT_COMMAND="fd --type f --strip-cwd-prefix"
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

# function _parent_dirs --on-variable PWD
#     set -g _parent_dirs (string escape (
#         for dir in (string split / -- $PWD)
#             set -la parts $dir
#             string join / -- $parts
#         end))
# end
#
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
#     printf '❯ '
#
# end

function nvim_dir
    set dir $(fd fi --type d | fzf) 
    if [ -n "$dir" ]
        cd $dir
    end
end
alias nd nvim_dir 

alias ls='eza -a --icons --colour never'
alias ll='eza -al --icons --colour never'
alias lt='eza -a --tree --level=1 --icons --colour never'
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

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

abbr kw khal calendar today 7d
abbr kl khal list today 14d 
abbr kt khal list today 
abbr km khal calendar today 30d
abbr kn khal new -a 
alias ke='khal edit $(khal list today 7d --format "{title}" | fzf)'
alias kel='khal edit $(khal list 365d --format "{title}" | fzf)'
abbr ks khal search

abbr gP git push
abbr gp git pull
abbr ga git add 
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

abbr zh zathura

bind ctrl-o fish_commandline_append execute
