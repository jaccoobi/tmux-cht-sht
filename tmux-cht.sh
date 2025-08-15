#!/usr/bin/env bash

print_cmd=less
if hash bat 2>/dev/null; then
  print_cmd=bat
fi

selected=`cat ~/.tmux/.tmux-cht-languages ~/.tmux/.tmux-cht-command | fzf`
if [[ -z $selected ]]; then
    exit 0
fi

echo $print_cmd
read -p "Enter Query: " query

if grep -qs "$selected" ~/.tmux/.tmux-cht-languages; then
    query=`echo $query | tr ' ' '+'`
    tmux neww bash -c "curl cht.sh/$selected/$query | $print_cmd"
else
    tmux neww bash -c "curl -s cht.sh/$selected~$query | $print_cmd"
fi

