#!/usr/bin/env bash

__ci () {
  set -u

  lint () {
    lint-shell
  }

  lint-shell () {
    docker run --rm -v "$(pwd):/mnt" koalaman/shellcheck:v0.5.0 \
    --exclude=SC1090,SC1091 \
    script/*.*sh \
    && docker run --rm -v "$(pwd):/mnt" koalaman/shellcheck:v0.5.0 \
    --exclude=SC1090,SC1091,SC2148 \
    .bash_*
  }

  @info () {
    MESSAGE="${1:-''}"
    echo "[$(basename "$0")] INFO: ${MESSAGE}"
  }

  @error () {
    MESSAGE="${1:-'Something went wrong.'}"
    echo "[$(basename "$0")] ERROR: ${MESSAGE}" >&2
    exit 1
  }

  @usage () {
    readonly SCRIPT_NAME=$(basename "$0")
    echo -e "${SCRIPT_NAME} -- dotfiles
    \\nUsage: ${SCRIPT_NAME} [arguments]
    \\nArguments:"
    declare -F | awk '{print "\t" $3}' | grep -v "@" | grep -v "__"
  }

  if [ $# = 0 ]; then
    @usage
  elif [ "$(type -t "$1")" = "function" ]; then
    $1
  else
    @usage && @error "Command '$1' not found."
  fi
}

__ci "$@"
