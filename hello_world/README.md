# hello_world

> Add Extism dependency
```bash
cargo add extism-pdk@1.0.0-rc1
```

> Build the wasm plug-in:
```bash
cargo clean
cargo build --release --target wasm32-wasi
```

> Serve the wasm plug-in with Simplism:
```bash
simplism listen \
./target/wasm32-wasi/release/hello_world.wasm handle \
--http-port 8080 \
--log-level info
```

> Query the wasm plug-in:
```bash
curl http://localhost:8080 \
-H 'content-type: application/json; charset=utf-8' \
-d '{"firstName":"Bob","lastName":"Morane"}'
```

## Dockerize the service

### Build the Docker image

```bash
IMAGE_NAME="hello_world-simplism"
docker login -u ${DOCKER_USER} -p ${DOCKER_PWD}
docker build -t ${IMAGE_NAME} . 

docker images | grep ${IMAGE_NAME}
```

### Create and run the container

```bash
IMAGE_NAME="hello_world-simplism"
docker run \
  -p 8080:8080 \
  --rm ${IMAGE_NAME}
```

### Push the image to the Docker Hub

```bash
IMAGE_NAME="hello_world-simplism"
docker tag ${IMAGE_NAME} ${DOCKER_USER}/${IMAGE_NAME}:0.0.0
docker push ${DOCKER_USER}/${IMAGE_NAME}:0.0.0
```