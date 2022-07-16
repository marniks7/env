run-env:
	docker run --network host --add-host=host.docker.internal:host-gateway -it \
		-v ${PWD}:${PWD} \
		--mount type=bind,source=${PWD}/.bash_history,target=/root/.bash_history \
		-v /var/run/docker.sock:/var/run/docker.sock --workdir ${PWD} \
		--user=$(id -u):$(id -g) \
 		dev-env bash -c './start.sh'
stop-env:
	docker run --network host --add-host=host.docker.internal:host-gateway -it \
		-v ${PWD}:${PWD} \
		--mount type=bind,source=${PWD}/.bash_history,target=/root/.bash_history \
		-v /var/run/docker.sock:/var/run/docker.sock --workdir ${PWD} \
		--user=$(id -u):$(id -g) \
 		dev-env bash -c './stop.sh'
run-env-runner:
	docker run --network host --add-host=host.docker.internal:host-gateway -it \
		-v ${PWD}:${PWD} \
		--mount type=bind,source=${PWD}/.bash_history,target=/root/.bash_history \
		-v /var/run/docker.sock:/var/run/docker.sock --workdir ${PWD} \
		--user=$(id -u):$(id -g) \
 		dev-env bash -c './torunner.sh && bash'
run-env-target:
	docker run --network host --add-host=host.docker.internal:host-gateway -it \
		-v ${PWD}:${PWD} \
		--mount type=bind,source=${PWD}/.bash_history,target=/root/.bash_history \
		-v /var/run/docker.sock:/var/run/docker.sock --workdir ${PWD} \
		--user=$(id -u):$(id -g) \
 		dev-env bash -c './totarget.sh && bash'