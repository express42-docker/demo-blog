FROM express42/ruby:dockermk-mar

HEALTHCHECK CMD curl --fail http://localhost:9292 || exit 1  
CMD ["/usr/local/bundle/bin/puma"]
