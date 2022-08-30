# Development Environment

Tired out to download and install applications. Going to use docker container instead.
In case You find this repo useful - the best approach I see is to fork it and modify however you wish

List of Software Installed:

* Docker
* Kind, K3d, Kubectl, Krew, Helm
* Tekton, Kpt
* git, make, yq, nano

## Features

1. [x] Autocompletion (whenever present)
2. [x] Persist bash history
3. [x] Script on init
    * for example, merge kubeconfig from k3d
4. [x] Access to docker inside container
5. [x] Current directory attached

## Run

1. Go to the directory where you are going to use it
2. `touch .bash_history`
3. Run:
   (for better experience copy this to `Makefile`)

```
docker run --network host --add-host=host.docker.internal:host-gateway -it \
   -v ${PWD}:${PWD} \
   --mount type=bind,source=${PWD}/.bash_history,target=/root/.bash_history \
   -v /var/run/docker.sock:/var/run/docker.sock --workdir ${PWD} \
   --user=$(id -u):$(id -g) \
   marniks7/env
```

4. To run with init script add to the end
   ` bash -c './init.sh && bash'`

## Absent Features

1. [ ] No programming languages installed so far (e.g. python, go, js, java)
    * And may not be installed there at all because it is usually used on local system
2. [ ] Manual versions update (e.g. no bot connected)
3. [ ] Impossible to reuse [Dockerfile](Dockerfile) scripts for local system.
   See [Local System Analyze](docs/local-system.md)
4. [ ] SElinux docs
5. [ ] WSL docs
6. [ ] Non-privileged docker image
7. [ ] CI option

## Alternatives

I didn't try (because of the image size, 20GB+ compressed, 60GB extracted), but they contain all the tooling.

* Local Github Actions Env Images used in [act](https://github.com/nektos/act)
    - [docker images](https://github.com/catthehacker/docker_images)
    - [official github virtual-environments](https://github.com/actions/virtual-environments)

## Thoughts

That [Dockerfile](DockerfileBuildx) looks like too much manual work, so maybe there are other managed distributions
which
provides all the packages. Based on fast check on [packages](https://pkgs.org/) it doesn't look like that.
Some other options considered: [other base images](other) doesn't contain everything either