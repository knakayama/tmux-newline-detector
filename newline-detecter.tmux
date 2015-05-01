#!/bin/bash

CURRENT_DIR="$(cd "$(dirname "$0")" && pwd)"

peek_key() {
  local peek_default_key="P"
  local peek_option="@peek"
  local peek_optional_key="$(tmux show-option -gqv "$peek_option")"

  if [[ -n "$peek_optional_key" ]]; then
    echo "$peek_optional_key"
  else
    echo "$peek_default_key"
  fi
}

paste_key() {
  local paste_default_key=']'
  local paste_option="@paste"
  local paste_optional_key="$(tmux show-option -gqv "$paste_option")"

  if [[ -n "$paste_optional_key" ]]; then
    echo "$paste_optional_key"
  else
    tmux unbind-key "$paste_default_key"
    echo "$paste_default_key"
  fi
}

tmux bind-key "$(peek_key)"  split-window "${CURRENT_DIR}/scripts/peek.sh"
tmux bind-key "$(paste_key)" run-shell    "${CURRENT_DIR}/scripts/paste.sh"
