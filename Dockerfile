FROM caddy:builder AS builder

ARG XCADDY_ARGUMENTS

ADD build.sh /build/
RUN chmod +x /build/build.sh && \
    sh -c /build/build.sh

FROM alpine:3

RUN set -eux; \
    mkdir -p \
    /config/caddy \
    /data/caddy \
    /etc/caddy \
    /usr/share/caddy

ADD Caddyfile /etc/caddy/
ADD index.html /usr/share/caddy/

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
RUN set -eux; \
    caddy version

# set up nsswitch.conf for Go's "netgo" implementation
# - https://github.com/docker-library/golang/blob/1eb096131592bcbc90aa3b97471811c798a93573/1.14/alpine3.12/Dockerfile#L9
RUN [ ! -e /etc/nsswitch.conf ] && echo 'hosts: files dns' > /etc/nsswitch.conf

ENV XDG_CONFIG_HOME /config
ENV XDG_DATA_HOME /data
VOLUME /config
VOLUME /data

EXPOSE 80
EXPOSE 443
EXPOSE 2019

WORKDIR /srv

CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]
