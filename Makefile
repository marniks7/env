
#-------------main--------------
build-env:
	docker buildx build --platform linux/amd64 -t marniks7/dev-env --progress plain --load .
run-env:
	docker run --network host --add-host=host.docker.internal:host-gateway -it \
		-v ${PWD}:${PWD} \
		--mount type=bind,source=${PWD}/.bash_history,target=/root/.bash_history \
		-v /var/run/docker.sock:/var/run/docker.sock --workdir ${PWD} \
		--user=$(id -u):$(id -g) \
 		marniks7/dev-env bash -c './init.sh && bash'