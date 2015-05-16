#!/usr/bin/env bash

is_command_available() {
  local cmd="$1"

  which "$cmd" >/dev/null 2>&1
}

is_osx() {
  [[ "$(uname)" == "Darwin" ]]
}
