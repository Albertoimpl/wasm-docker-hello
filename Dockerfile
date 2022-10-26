FROM scratch

ENTRYPOINT ["hello-world.wasm"]

COPY /hello-world.wasm /hello-world.wasm
