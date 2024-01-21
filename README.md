# Simplism Builder

**Simplism Builder** is a Docker Compose project bringing all the necessary tools to build **WASM** [Extism](https://extism.org/) plug-ins for [Simplism](https://github.com/bots-garden/simplism).

**Simplism Builder** comes with:

- GoLang compiler
- Tinygo compiler
- Rustc and Cargo
- Simplism executable

That means you don't need to install anything (except Docker) to build wasm plug-ins on your computer.

## How to start the builder
> git clone this repository

**Start the builder**:
```bash
docker compose --env-file arm64.env up  -d
# docker compose --env-file amd64.env up  -d
```
> - ✋ if you are on a arm architecture (mac silicon or linux arm) use `arm64.env`
> - otherwise use `amd64.env`


If you updated `./.docker/Dockerfile` or get a new version of this project, run this command before starting the builder:
```bash
docker compose --env-file arm64.env build
# docker compose --env-file amd64.env build
```

**Stop the builder**:
```bash
docker compose --env-file arm64.env down
# docker compose --env-file amd64.env down
```

## Use the builder

Once the builder started, you can use it like this:
```bash
docker exec --workdir /workspace -it simplism-builder /bin/bash
```

Now you can build [Extism](https://extism.org/) plug-ins for [Simplism](https://github.com/bots-garden/simplism). Try this:

```bash
simplism generate go hello-world .
cd hello-world
go get github.com/extism/go-pdk
tinygo build -scheduler=none --no-debug \
-o hello-world.wasm \
-target wasi main.go
# wait for some seconds...
```

Then start Simplism to serve the new plug-in:

```bash
simplism listen \
hello-world.wasm handle --http-port 8080 --log-level info
```

And in a terminal from the host:

```bash
curl http://localhost:9090 \
-H 'content-type: application/json; charset=utf-8' \
-d '{"firstName":"Bob","lastName":"Morane"}'
```
> 👋 the host port (`9090`) is mapped on the container port (`8080`).

## Add "tasks" at start of the builder

If you want to start some initial tasks once the builder container is started, you can update `./.tasks/init.sh`

