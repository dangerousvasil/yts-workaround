## Makefile project

# detect builder
builder = docker
ifeq ("$(shell type podman>/dev/null; echo $$?)", "0")
builder := podman
endif

container_name ?= yts-workaround

container/init:
	-mkdir "appbuild"

container/clean:
	-rm -r "appbuild"

container/bin:
	make container/init
	GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o build/application

container/build:
	make container/bin
	$(builder) build \
	 -t "$(container_name)" .
	make container/clean

run:
	make container/build
	$(builder) run --platform linux/amd64 -it "$(container_name)"

