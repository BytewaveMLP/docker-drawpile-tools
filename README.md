# Docker Drawpile Tools

> Dockerized tools for working with Drawpile sessions

## Usage

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
