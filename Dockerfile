FROM ubuntu:19.10

USER root

RUN apt-get update -y \
 && apt-get install -y \
    git \
    ocaml \
    ocaml-native-compilers \
    liblablgtk2-ocaml-dev \
    liblablgtksourceview2-ocaml-dev \
    libocamlgraph-ocaml-dev \
    menhir \
    why3 \
    libyojson-ocaml-dev \
    libocamlgraph-ocaml-dev \
    libzarith-ocaml-dev \
    build-essential \
    libfindlib-ocaml \
    libocamlgraph-ocaml-dev \
    libzarith-ocaml \
    libyojson-ocaml-dev \
    alt-ergo \
    curl \
    frama-c-base \
 && rm -rf /var/lib/apt/lists/* 
 
RUN groupadd -r frama-c \
 && useradd --no-log-init -r -g frama-c frama-c

WORKDIR /build
RUN curl "http://www.lsv.fr/~gastin/ltl2ba/ltl2ba-1.2.tar.gz" --output ltl2ba-1.2.tar.gz \
  && tar xvfz ltl2ba-1.2.tar.gz \
  && cd ltl2ba-1.2 \
  && make \
  && mv ltl2ba /usr/local/bin

USER frama-c
WORKDIR /src
ENTRYPOINT ["frama-c"]
