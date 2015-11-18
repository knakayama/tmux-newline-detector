#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "${CURRENT_DIR}/helpers.sh"

if is_osx && is_command_available 'reattach-to-user-namespace'; then
  reattach-to-user-namespace pbpaste | tmux load-buffer -
fi

args="$*"
buffer="0"
# Grab a buffer selector if one exists
if [ $(echo "$args" | grep -P '[-]b \S+') ]
then
  args="$(echo "$args" | sed -r 's/\s*[-]b \S+\s*/ /')"
  buffer="$(echo "$args" | sed -r 's/.*\b[-]b \(\S+\)\b*.*/\1/')"
fi

# remove newline if one sentence
#
# wc -l works fine here; test example: 
# $ echo -e 'foo\nbar\rbaz\r\nqux\n\rwibble\n' | wc -l
# 5
if [[ $(tmux show-buffer -b $buffer | wc -l) -eq 1 ]]; then
  tmux show-buffer -b $buffer | tr -d '\n' | tmux load-buffer -b $buffer -
fi

if [[ $(tmux show-buffer -b $buffer | wc -l) -gt 0 ]]; then
  tmux confirm-before -p "This paste contains newlines; paste anyway?(y/n)" "run-shell 'tmux paste-buffer -b $buffer $args'"
else
  tmux paste-buffer -b $buffer $args
fi
