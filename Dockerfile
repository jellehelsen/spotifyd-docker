FROM alpine:latest
MAINTAINER Jelle Helsen <jelle.helsen@hcode.be>
RUN apk add --no-cache spotifyd
RUN sed -i '/username\|password\|device_name/d' /etc/spotifyd.conf
ENV DEVICE_NAME="spotifyd"
ENTRYPOINT spotifyd --no-daemon -d "$DEVICE_NAME"
