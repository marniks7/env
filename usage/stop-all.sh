#!/bin/bash

script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "${script_dir}"/runner/stop.sh
source "${script_dir}"/target/stop.sh