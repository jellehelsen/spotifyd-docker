FROM alpine:latest
MAINTAINER Jelle Helsen <jelle.helsen@hcode.be>
RUN apk add --no-cache spotifyd
ENV SPOTIFY_USER=""
ENV SPOTIFY_PASSWORD=""
ENV DEVICE_NAME="spotifyd"
ENTRYPOINT spotifyd --no-daemon -u $SPOTIFY_USER -p $SPOTIFY_PASSWORD -d $DEVICE_NAME
