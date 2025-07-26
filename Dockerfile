FROM alpine:latest

RUN apk update
RUN apk add --no-cache curl jq bash ca-certificates

ENV CF_CLI_VERSION "8.14.1"

RUN curl -L "https://packages.cloudfoundry.org/stable?release=linux64-binary&version=${CF_CLI_VERSION}&source=github-rel" | tar -zx -C /usr/local/bin

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]