#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "$0")" && pwd)"

source "${CURRENT_DIR}/helpers.sh"

if is_osx && is_command_available 'reattach-to-user-namespace'; then
  reattach-to-user-namespace pbpaste | tmux load-buffer -
fi

args="$*"
buffer="$(tmux list-buffers | sed 's/:.*//' | head -n 1)"
# Grab a buffer selector if one exists
if echo "$args" | grep -P '\s[-]b\s+\S+' >/dev/null 2>&1
then
  buffer="$(echo "$args" | sed -r 's/.*\s+[-]b\s+(\S+).*/\1/')"
  args="$(echo "$args" | sed -r 's/\s+[-]b\s+\S+\s*/ /')"
fi

# remove any trailing newlines; works because shell command
# substitutions remove trailing newline characters ; see
# http://stackoverflow.com/a/12148703
#
# We do this because some systems/versions of tmux have a trailing
# newline for single-line items, and some don't.
#
printf %s "$(tmux show-buffer -b $buffer)" | tmux load-buffer -b $buffer -

if [ "$(tmux show-buffer -b $buffer | wc -l)" -gt 0 ]
then
  tmux confirm-before -p "This paste contains newlines; paste anyway?(y/n)" "run-shell 'tmux paste-buffer -b $buffer $args'"
else
  tmux paste-buffer -b $buffer $args
fi
