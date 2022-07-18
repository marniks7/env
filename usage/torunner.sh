#!/bin/bash

dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
source "${dir}"/runner/api.sh

changeTerminalTitleRunner
kubectlSwitchToRunner
portForwardTektonDashboard
infoRunner