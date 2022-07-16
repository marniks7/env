#!/bin/bash

dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
source "${dir}"/api.sh

changeTerminalTitleRunner
kubectlSwitchToRunner
portForwardTektonDashboard
infoRunner