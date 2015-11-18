#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "${CURRENT_DIR}/helpers.sh"

if is_osx && is_command_available 'reattach-to-user-namespace'; then
  reattach-to-user-namespace pbpaste | tmux load-buffer -
fi

# remove newline if one sentence
#
# wc -l works fine here; test example: 
# $ echo -e 'foo\nbar\rbaz\r\nqux\n\rwibble\n' | wc -l
# 5
if [[ $(tmux show-buffer | wc -l) -eq 1 ]]; then
  tmux show-buffer | tr -d '\n' | tmux load-buffer -
fi

if tmux show-buffer | hexdump | grep -qE '[[:space:]](0[ad]|0d0a)[[:space:]]?'; then
  tmux confirm-before -p "Include newline. Paste?(y/n)" "run-shell 'tmux paste-buffer $@'"
else
  tmux paste-buffer "$@"
fi
