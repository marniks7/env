#!/bin/bash

dir=$(cd -P -- "$(dirname -- "$0")" && pwd -P)

source "${dir}"/target/start.sh
source "${dir}"/runner/start.sh