FROM ubuntu:16.04

RUN apt-get update && apt-get install -fy \
		curl \
    && rm -rf /var/lib/apt/lists/*

COPY sources.list /etc/apt/sources.list
