FROM ruby

RUN mkdir /app
WORKDIR /app

ADD . /app

ENTRYPOINT ["/usr/local/bin/ruby", "/app/exe/cli"]
