FROM alpine:latest

RUN apk add --no-cache postgresql-client

RUN echo "\\pset pager off" > ~/.psqlrc

ENTRYPOINT ["/bin/sh"]