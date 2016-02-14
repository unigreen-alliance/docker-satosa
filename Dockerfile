FROM ubuntu:14.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    python3-dev \
    build-essential \
    python3-pip \
    libffi-dev \
    libssl-dev \
    xmlsec1 \
    libyaml-dev

RUN pip3 install satosa==0.6.1

COPY start.sh /tmp/satosa/start.sh
ENTRYPOINT ["/tmp/satosa/start.sh"]
