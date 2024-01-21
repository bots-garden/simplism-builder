FROM k33g/simplism:0.1.2
COPY hello_world.wasm .
EXPOSE 8080
CMD ["/simplism", "listen", "hello_world.wasm", "handle", "--http-port", "8080", "--log-level", "info"]
