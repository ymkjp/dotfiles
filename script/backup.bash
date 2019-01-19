#!/usr/bin/env bash

_backup () {
  set -u
  PID_FILE="backup.pid"

  # https://rclone.org/dropbox/
  # https://www.dropbox.com/home/backup
  # @TODO rename "mine:backup" to "mine:backup-$(hostname)"
  start () {
    CURRENT_TIME="$(date +'%s')"
    BACKUP_TARGET="$(dirname $0)/backup-target.txt"
    LOG_FILE="$(dirname $0)/../log/backup-${CURRENT_TIME}.log"
    nohup rclone copy --filter-from "${BACKUP_TARGET}" / mine:backup >> "${LOG_FILE}" 2>&1 &
    echo $! > "${PID_FILE}"
  }

  status () {
  if [[ -f "${PID_FILE}" ]]; then
      PID="$(cat ${PID_FILE})"
      watch ps -u --pid "${PID}"
    else
      _error "${PID_FILE} was not found"
    fi
  }

  stop () {
    if [[ -f "${PID_FILE}" ]]; then
      PID="$(cat ${PID_FILE})"
      kill "${PID}" && rm -f "${PID_FILE}" || _error
    else
      _error "${PID_FILE} was not found"
    fi
  }

  log () {
    tail -f "$(dirname $0)/../log/backup-"*".log"
  }

  _info () {
    MESSAGE="${1:-''}"
    echo "[$(basename "$0")] INFO: ${MESSAGE}"
  }

  _error () {
    MESSAGE="${1:-'Something went wrong.'}"
    echo "[$(basename "$0")] ERROR: ${MESSAGE}" >&2
    exit 1
  }

  _usage () {
    readonly SCRIPT_NAME=$(basename "$0")
    echo -e "Usage: ${SCRIPT_NAME} [arguments]
    \\nArguments:"
    declare -F | awk '{print "\t" $3}' | grep -v $'^\t_'
  }

  if [[ $# = 0 ]]; then
    _usage
  elif [[ "$(type -t "$1")" = "function" ]]; then
    $1
  else
    _usage && _error "Command '$1' not found."
  fi
}

_backup "$@"
