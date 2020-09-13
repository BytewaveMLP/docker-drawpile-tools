# Docker Drawpile Tools

> Dockerized tools for working with Drawpile sessions

## Usage

This container is published on Docker Hub as [`bytewave81/drawpile-tools`](https://hub.docker.com/r/bytewave81/drawpile-tools), and on GitHub Packages as [`ghcr.io/bytewavemlp/drawpile-tools`](https://github.com/users/BytewaveMLP/packages/container/drawpile-tools). Which repo you choose to pull from is up to you.

By default, the container's entrypoint is `drawpile-cmd`.

```shell
$ docker run --rm -it \
	-v /path/to/drawpile/sessions:/drawpile \
	ghcr.io/bytewavemlp/drawpile-tools \
	--help # flags for drawpile-cmd go here
```

If you need to use `dprectool` instead:

```shell
$ docker run --rm -it \
	-v /path/to/drawpile/sessions:/drawpile \
	--entrypoint dprectool \
	ghcr.io/bytewavemlp/drawpile-tools \
	--help # flags for dprectool go here
```

`/drawpile/output` can be used as an output directory which is guaranteed writeable by the container, if you'd like to mount over this with a volume.

## Known issues

- `drawpile-cmd -a` (merge annotations) doesn't work. This is probably due to the minimal image not including any fonts (yay Alpine!), or anything to handle fonts. 
