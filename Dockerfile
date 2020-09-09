ARG UBUNTU_VERSION=20.04

FROM ubuntu:${UBUNTU_VERSION} as builder
WORKDIR /build

RUN apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get -yq install --no-install-recommends build-essential cmake extra-cmake-modules libkf5archive-dev qtdeclarative5-dev qtmultimedia5-dev libqt5svg5-dev libvpx-dev libgif-dev wget ca-certificates unzip

ARG DRAWPILE_VERSION=master
RUN wget https://github.com/drawpile/Drawpile/archive/${DRAWPILE_VERSION}.zip -O ./drawpile.zip
COPY ./build.sh .
RUN ./build.sh

FROM ubuntu:${UBUNTU_VERSION}

COPY --from=builder /build/bin/dprectool /usr/local/bin
COPY --from=builder /build/bin/drawpile-cmd /usr/local/bin

RUN apt-get update \
	&& apt-get -y install --no-install-recommends libgif7 libkf5archive5 libqt5svg5 libvpx6 \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR /drawpile
RUN addgroup --system drawpile
RUN adduser \
	--system \
	--home /drawpile --no-create-home \
	--disabled-login --disabled-password \
	--ingroup drawpile \
	drawpile

USER drawpile
ENTRYPOINT [ "drawpile-cmd" ]

LABEL maintainer="Eliot Partridge <byte@code.horse>"
