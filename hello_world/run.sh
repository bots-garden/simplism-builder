#!/bin/bash
simplism listen \
./target/wasm32-wasi/release/hello_world.wasm handle --http-port 8080 --log-level info
