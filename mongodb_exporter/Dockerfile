FROM express42/ubuntu:16.04

LABEL   Name="express42/mongodb_exporter"
LABEL   Version="1.0"

COPY prometheus/mongodb_exporter /bin/mongodb_exporter

EXPOSE 9001

CMD ["mongodb_exporter"]
