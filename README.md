# Docker and WASM

Testing https://docs.docker.com/desktop/wasm/

## Install WASI SDK

https://github.com/WebAssembly/wasi-sdk

```shell
wget https://github.com/WebAssembly/wasi-sdk/releases/download/wasi-sdk-16/wasi-sdk-16.0-macos.tar.gz
tar xvf wasi-sdk-16.0-macos.tar.gz
```

## Creating a WASM module using WASI SDK

```shell
export WASI_SDK_PATH=`pwd`/wasi-sdk-16.0
CC="${WASI_SDK_PATH}/bin/clang"
$CC hello-world.c -o hello-world.wasm
```

## Building a docker image

https://github.com/docker/docs/blob/main/desktop/wasm/index.md

```shell
docker buildx build . --file=Dockerfile --tag=albertoimpl/hello-wasm-docker --platform wasi/wasm32
```

Just 9.65kB!

```shell
docker images
REPOSITORY                                                          TAG       IMAGE ID       CREATED      SIZE
albertoimpl/hello-wasm-docker                                       latest    22617e0cb703   8 days ago   9.65kB
hello-world                                                         latest    e18f0a777aef   8 days ago   7.04kB
```

## Running the docker image

```shell
docker run --runtime=io.containerd.wasmedge.v1 --platform=wasi/wasm32 albertoimpl/hello-wasm-docker
```

As fast as a docker hello world:

```asciidoc
time docker run hello-world
0.07s user 0.04s system 17% cpu 0.584 total

time docker run --runtime=io.containerd.wasmedge.v1 --platform=wasi/wasm32 albertoimpl/hello-wasm-docker
0.07s user 0.03s system 18% cpu 0.548 total
```
