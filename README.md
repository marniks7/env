# Development Environment

Tired out to download and install applications. Going to use docker container instead.
In case You find this repo useful - the best approach I see is to fork it and modify however you wish

1. `make build-env-buildx`
2. `make run-env`

## Features

1. [x] The list of tools in dockerfile in mine (whatever I use\used)
    * can be copy-pasted and used your own
2. [x] Autocompletion (whenever present)
3. [x] Persist bash history
4. [x] Script on init
    * for example, retrieve kubeconfig from k3d
5. [x] Access to docker inside container
6. [x] Current directory attached

## Absent Features

1. [ ] No programming languages installed so far (like python, go, js, java)
    * And may not be installed there at all because it is what is usually used in IDE most of the time
2. [ ] Manual versions update (eg no bot connected)
3. [ ] Hard \ impossible to reuse [DockerfileBuildx](DockerfileBuildx) scripts for local system (especially if it is not
   linux-amd64)

## Alternatives

I didn't try (because of the image size, 20GB+), but they contain all the tooling.

* Local Github Actions Env Images used in [act](https://github.com/nektos/act)
    - [docker images](https://github.com/catthehacker/docker_images)
    - [official github virtual-environments](https://github.com/actions/virtual-environments)

## Thoughts

That [Dockerfile](DockerfileBuildx) looks like too much manual work, so maybe there are other managed distributions
which
provides all the packages. Based on fast check on [packages](https://pkgs.org/) it doesn't look like that.
Some other options considered: [other base images](tests) doesn't contain everything