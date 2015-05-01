#!/bin/bash

CURRENT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "${CURRENT_DIR}/helpers.sh"

if is_osx && is_command_available 'reattach-to-user-namespace'; then
  reattach-to-user-namespace pbpaste | tmux load-buffer -
fi

tmux show-buffer | less
