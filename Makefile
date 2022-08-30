
#-------------main--------------
build-env:
	docker buildx build --platform linux/amd64 -t marniks7/env --progress plain --load .
run-env:
	touch .bash_history && docker run --network host --add-host=host.docker.internal:host-gateway -it \
		-v ${PWD}:${PWD} --workdir ${PWD} \
		--mount type=bind,source=${PWD}/.bash_history,target=/root/.bash_history \
		-v /var/run/docker.sock:/var/run/docker.sock \
 		marniks7/env bash -c './init.sh && bash'