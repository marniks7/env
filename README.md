# Development Environment

Tired out to download and install applications. Going to use docker container instead.

1. `make build-env`
2. `make run-env`

## Features
1. [x] The list of tools in dockerfile in mine (whatever I use\used)
    * can be copy-pasted and used your own
2. [x] Autocompletion (whenever present)
3. [x] Persist bash history
4. [x] Script on init
   * for example, create kubeconfig
5. [x] Access to docker inside container
6. [x] Attach current directory

## Absent Features
1. [ ] No languages installed (like python, go, js, java) so far
2. [ ] Manual versions update

## Alternatives

I didn't try them (because of the image size, 20GB+), but they contain all the tooling.

* Official Github Actions Env images [virtual-environments](https://github.com/actions/virtual-environments)
* Local Github Actions Env Images used in [act](https://github.com/nektos/act)
    - [docker images](https://github.com/catthehacker/docker_images)

## Thoughts
* That [Dockerfile](Dockerfile) looks like too much manual work. However [alpine packages](https://pkgs.alpinelinux.org/packages)