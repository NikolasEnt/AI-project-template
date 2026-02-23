# TODO: Rename it to your project name and update version accordingly
PROJECT_NAME=my-python-project
VERSION=0.1.0

IMAGE_NAME=$(PROJECT_NAME):$(VERSION)
CONTAINER_NAME=--name=$(PROJECT_NAME)

NET=--net=host
IPC=--ipc=host
BUILD_NET=--network=host

# Specify which GPU the container can see, e.g.: all gpus if called without
# options, or a specific GPU if called with GPUS='"device=1"'.
GPUS?=all
ifeq ($(GPUS),none)
	GPUS_OPTION=--gpus=all
else
	GPUS_OPTION=--gpus=$(GPUS)
endif

.PHONY: all build stop run logs

all: build stop run logs

build:
	docker build $(BUILD_NET) -t $(IMAGE_NAME) -f Dockerfile .


CONTAINER_FILTER := "name=$(PROJECT_NAME)*"

stop:
	@ids=$$(docker ps -q --filter $(CONTAINER_FILTER)); \
	if [ -n "$$ids" ]; then \
		echo "Stopping containers of $(PROJECT_NAME): $$ids"; \
		docker stop $$ids; \
	else \
		echo "No running containers found to stop."; \
	fi

kill:
	@ids=$$(docker ps -aq --filter $(CONTAINER_FILTER)); \
	if [ -n "$$ids" ]; then \
		echo "Force removing containers of $(PROJECT_NAME): $$ids"; \
		docker rm -f $$ids; \
	else \
		echo "No containers found to remove."; \
	fi

run:
	docker run --rm -it $(GPUS_OPTION) \
		$(NET) $(IPC) \
		-v $(shell pwd):/workdir/ \
		$(CONTAINER_NAME) \
		$(IMAGE_NAME) \
		bash

logs:
	docker logs -f $(PROJECT_NAME)
