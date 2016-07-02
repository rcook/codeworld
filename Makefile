IMAGE := codeworld

.PHONY: default
default:

# Create Docker image
.PHONY: image
image:
	@docker build --tag $(IMAGE) .

# Run ephemeral build shell based on Docker image
.PHONY: shell
shell:
	@docker run --rm --interactive --tty --volume $(CURDIR):/codeworld/src $(IMAGE)

# Clean Docker images and containers
.PHONY: clean
clean:
	@CONTAINERS=$$(docker ps --quiet --no-trunc --all --filter="status=exited") && \
	  if [ "$$CONTAINERS" != "" ]; then \
	    docker rm $$CONTAINERS; \
	  fi;
	@IMAGES=$$(docker images --quiet --filter="dangling=true") && \
	  if [ "$$IMAGES" != "" ]; then \
	    docker rmi $$IMAGES; \
	  fi;
