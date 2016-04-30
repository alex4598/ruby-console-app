#!/bin/bash

main() {
  RUBY=ruby
  HOME="$(cd "`dirname "${0}"`" && pwd || shellScriptException ${LINENO} ${?})"
  THIS="$(basename "${0}")"
  APP="${THIS%.*}"
  LOG="${APP}.log"
  FACTER_HOME="${HOME}/"
  FACTER_CONF="${APP}.ini"
  FACTER_LOG="${LOG}"
  FACTER_ARGUMENTS="${*}"
  [ -z "${FACTER_ARGUMENTS// }" ] && FACTER_ARGUMENTS='none'
  export FACTER_HOME
  export FACTER_CONF
  export FACTER_ARGUMENTS
  export FACTER_LOG
  logAppend "INFO Starting ${APP} application from ${HOME}"
  cd "${HOME}" || shellScriptException ${LINENO} ${?}
  eval "${RUBY} "${APP}.rb"" || shellScriptException ${LINENO} ${?}
  logAppend "INFO Finished running ${APP} application from ${HOME}"
  exit 0
}

logAppend() { echo "$(date +"%Y-%m-%d-%H-%M-%S") ${*}" | tee -a ${LOG}; }

shellScriptException() {
  this=${FUNCNAME[0]}
  line=${1}
  exit_code=${2}
  logAppend "ERROR ${this} on line ${line}, exit code ${exit_code}"
  exit 1
}

main "${@}"
