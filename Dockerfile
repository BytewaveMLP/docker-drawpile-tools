# Modified from Drawpile's build scripts
# https://github.com/drawpile/Drawpile/tree/master/pkg/docker

ARG ALPINE_VERSION=3.9

FROM alpine:${ALPINE_VERSION} as common
RUN apk add --no-cache qt5-qtbase qt5-qtbase-x11 libbz2

FROM common as builder

WORKDIR /build

RUN apk add qt5-qtbase-dev qt5-qtsvg-dev qt5-qtmultimedia-dev cmake make g++

COPY ./build-deps.sh .
RUN ./build-deps.sh

ARG DRAWPILE_VERSION=master
RUN wget https://github.com/drawpile/Drawpile/archive/${DRAWPILE_VERSION}.zip -O ./drawpile.zip
COPY ./build.sh .
RUN ./build.sh


FROM common

COPY --from=builder /build/karchive*/build/bin/libKF5* /usr/lib/
COPY --from=builder /build/bin/dprectool /bin
COPY --from=builder /build/bin/drawpile-cmd /bin

WORKDIR /drawpile
RUN addgroup --system drawpile \
	&& \
	adduser \
	--system \
	--home /drawpile --no-create-home \
	--disabled-password \
	--ingroup drawpile \
	drawpile

USER drawpile
ENTRYPOINT [ "/bin/drawpile-cmd" ]

LABEL maintainer="Eliot Partridge <byte@code.horse>"
