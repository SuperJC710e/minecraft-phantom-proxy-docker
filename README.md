# Docker image for jhead's Phantom proxy

As described by jhead:
>Makes hosted Bedrock/MCPE servers show up as LAN servers, specifically for consoles.
>You can now play on remote servers (not Realms!) on your Xbox and PS4 with friends.
>It's like having a LAN server that's not actually there, spooky.

## Basic usage:

```bash
docker container run --name minecraft-phantom-proxy -e SERVER=<server_ip>:<server_port> --network host ghcr.io/superjc710e/minecraft-phantom-proxy:latest
```

Or with docker compose:

```bash
name: minecraft-phantom-proxy
services:
  minecraft-phantom-proxy:
    image: ghcr.io/superjc710e/minecraft-phantom-proxy:latest
    container_name: minecraft-phantom-proxy
    restart: always
    environment:
      - SERVER=example.com:19132
      # - BIND_PORT=0
      # - BIND_IP=0.0.0.0
      # - TIMEOUT=60
      # - IPV6=1
      # - DEBUG=1
      # - REMOVE_PORTS=1
      # - WORKERS=16
    network_mode: host
```

## Environment Variables

| Variable     | Required   | Description                                                                                                                                                                                                                                                                                          |
|--------------|------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| SERVER       | Required   | Bedrock/MCPE server address and the port.  Multiple servers can be specified by separating them with `;`  Example: `SERVER=192.168.1.5:19132;play.minecraftworld.com:19132`                                                                                                                          |
| IPV6         | *Optional* | Enables IPv6 support on port 19133. (experimental)  Pass `1` to enable this flag!  Example: `IPV6=1`                                                                                                                                                                                                 |
| BIND_IP      | *Optional* | IP address to listen on. Defaults to all interfaces.  **NB:** BIND_IP cannot be used when multiple servers are specified in SERVER.  default: `BIND_IP=0.0.0.0`                                                                                                                                      |
| BIND_PORT    | *Optional* | Port to listen on. Defaults to 0, which selects a random port.  **NB:** BIND_PORT cannot be used when multiple servers are specified in SERVER.  Example: `BIND_PORT=19133`                                                                                                                          |
| DEBUG        | *Optional* | Enables debug logging.  Pass `1` to enable this flag!  Example: `DEBUG=1`                                                                                                                                                                                                                            |
| REMOVE_PORTS | *Optional* | Forces ports to be excluded from pong packets (experimental).  Pass `1` to enable this flag!  Example: `REMOVE_PORTS=1`                                                                                                                                                                              |
| TIMEOUT      | *Optional* | Seconds to wait before cleaning up a disconnected client  default: `TIMEOUT=60`                                                                                                                                                                                                                      |
| WORKERS      | *Optional* | Specify the number of "threads" to use to process data from clients.  Example: `WORKERS=16`                                                                                                                                                                                                          |

*Note: host network mode required.*

[GitHub](https://github.com/SuperJC710e/minecraft-phantom-proxy-docker) |
[GitHub Container Registry](https://github.com/SuperJC710e/minecraft-phantom-proxy-docker/pkgs/container/minecraft-phantom-proxy)

Phantom written by Justin Head: [GitHub](https://github.com/jhead/phantom)

Docker image based on original image created by nkelemen18: [GitHub](https://github.com/nkelemen18/Minecraft-Phantom-Proxy-Docker) and adapted by Kirbo: [GitHub](https://github.com/Kirbo/Minecraft-Phantom-Proxy-Docker) and then further adapted by Lexi: [GitHub](https://github.com/lexiismadd/Minecraft-Phantom-Proxy-Docker) which used lastversion by dvershinin to extrapolate latest version of a github release: [GitHub](https://github.com/dvershinin/lastversion) in the entrypoint.sh script

This version reverts to building the current latest version of `phantom` into the image, instead of pulling it at every startup.
