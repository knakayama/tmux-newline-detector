#!/bin/bash

CURRENT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "${CURRENT_DIR}/helpers.sh"

if is_osx && is_command_available 'reattach-to-user-namespace'; then
  reattach-to-user-namespace pbpaste | tmux load-buffer -
fi

if tmux show-buffer | hexdump | grep -qE '[[:space:]](0a|0d|0d0a)[[:space:]]?'; then
  tmux confirm-before -p "Include newline. Paste?(y/n)" "run-shell 'tmux paste-buffer'"
else
  tmux paste-buffer
fi
