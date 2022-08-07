#-------------main--------------
build-env:
	docker buildx build --platform linux/amd64 -t marniks7/dev-env -f DockerfileBuildx  --progress plain --load .
build-env-old:
	docker build --network host -t marniks7/dev-env .
run-env:
	docker run --network host --add-host=host.docker.internal:host-gateway -it \
		-v ${PWD}:${PWD} \
		--mount type=bind,source=${PWD}/.bash_history,target=/root/.bash_history \
		-v /var/run/docker.sock:/var/run/docker.sock --workdir ${PWD} \
		--user=$(id -u):$(id -g) \
 		dev-env bash -c './init.sh && bash'