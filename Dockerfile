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

COPY SATOSA-2.1.0-py3-none-any.whl /SATOSA-2.0.0-py3-none-any.whl
RUN pip3 install /SATOSA-2.0.0-py3-none-any.whl

COPY start.sh /tmp/satosa/start.sh
ENTRYPOINT ["/tmp/satosa/start.sh"]
