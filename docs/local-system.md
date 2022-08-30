# Reuse for local system

### Problem Statement:

Impossible to reuse [DockerfileBuildx](../DockerfileBuildx) scripts for local system

### Why desired:

We would like to have access to certain tools & utilities without docker container?

1. Because using docker container introduce additional step and for regular-cases we would like to avoid it
2. Security issues to run that docker container with docker access
3. Security issues during usage, e.g. creating file as root will not be possible to user for current system
4. IDE provides support

### How to solve?
1. Convert existing Dockerfile to sh scripts
   https://github.com/thatkevin/dockerfile-to-shell-script
   https://linux.die.net/man/1/envsubst
3. Re-write Dockerfile to sh scripts
4. Docker export
   
### Difference
1. Local system may want to export to different directory, e.g. to user-folder
2. Different architecture