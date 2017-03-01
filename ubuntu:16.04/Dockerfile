FROM ubuntu:16.04

COPY sources.list /etc/apt/sources.list

RUN apt-get update && apt-get install -fy \
		inetutils-tools \
		dnsutils \
		iproute2 \
		wget \
		inetutils-ping \
		net-tools \
		curl \
    && rm -rf /var/lib/apt/lists/*
