build-env:
	docker build --network host -t dev-env .
build-env-test:
	docker build --network host -t dev-env -f DockerfileTest .
build-env-buildx:
	docker buildx build --platform linux/amd64 -t dev-env -f DockerfileTest --progress plain --load .
run-env:
	docker run --network host --add-host=host.docker.internal:host-gateway -it \
		-v ${PWD}:${PWD} \
		--mount type=bind,source=${PWD}/.bash_history,target=/root/.bash_history \
		-v /var/run/docker.sock:/var/run/docker.sock --workdir ${PWD} \
		--user=$(id -u):$(id -g) \
 		dev-env bash -c './init.sh && bash'