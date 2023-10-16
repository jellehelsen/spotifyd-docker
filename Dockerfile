FROM alpine:latest
MAINTAINER Jelle Helsen <jelle.helsen@hcode.be>
RUN apk add --no-cache spotifyd
ENV SPOTIFY_USER=""
env SPOTIFY_PASSWORD=""
ENTRYPOINT spotifyd --no-daemon -u $SPOTIFY_USER -p $SPOTIFY_PASSWORD
