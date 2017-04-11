FROM express42/ubuntu:16.04

LABEL   Name="express42/prometheus"
LABEL   Version="1.0"

COPY build/prometheus                             /bin/prometheus
COPY build/promtool                               /bin/promtool
COPY build/console_libraries/                     /etc/prometheus/
COPY build/consoles/                              /etc/prometheus/
COPY build/prometheus.yml                         /etc/prometheus/

EXPOSE     9090
VOLUME     [ "/opt/prometheus/data" ]
CMD        [ "prometheus" ]
