build:
	docker build -t terrashine:$(tag) .

publish:
	docker image tag terrashine:$(tag) hardandheavy/terrashine:$(tag)
	docker push hardandheavy/terrashine:$(tag)
	docker image tag terrashine:$(tag) hardandheavy/terrashine:latest
	docker push hardandheavy/terrashine:latest

bash:
	docker run -it --rm \
		--network=host \
		--env HTTPS_PROXY="socks5://127.0.0.1:9150" \
		terrashine:$(tag) bash

prepare:
	docker run --rm -it \
		-v $(CURDIR):/ansible \
		-v ./secure:/ansible/secure \
		willhallonline/ansible:latest ansible-playbook ansible/prepare.yml \
		-i ansible/prepare \
		-vv

gen: prepare
	docker run --rm -it \
		-v $(CURDIR):/ansible \
		-v ./secure:/ansible/secure \
		willhallonline/ansible:latest ansible-playbook ansible/gen.yml \
		-i ansible/gen \
		-vv

seed:
	docker exec tf-minio sh /seed.sh

run:
	docker compose up -d

stop:
	docker compose stop

.PHONY: seed
