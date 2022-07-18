#!/bin/bash

dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
source "${dir}"/target/api.sh

changeTerminalTitleTarget
kubectlSwitchToTarget
portForwardChaosMeshDashboard
portForwardApp
infoTarget