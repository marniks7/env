#!/bin/bash

script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)

"${script_dir}"/target/start.sh
"${script_dir}"/runner/start.sh
