#!/bin/bash

dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)
source "${dir}"/runner/stop.sh
source "${dir}"/target/stop.sh