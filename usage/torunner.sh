#!/bin/bash

script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "${script_dir}"/runner/api.sh

changeTerminalTitleRunner
kubectlSwitchToRunner
infoRunner