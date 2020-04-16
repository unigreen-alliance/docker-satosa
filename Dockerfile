FROM python:3.7.6-buster

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    python3-dev \
    build-essential \
    python3-pip \
    libffi-dev \
    libssl-dev \
    xmlsec1 \
    libyaml-dev

RUN pip3 install --upgrade pip setuptools
COPY .requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

COPY start.sh /tmp/satosa/start.sh
COPY attributemaps /tmp/satosa/attributemaps
ENTRYPOINT ["/tmp/satosa/start.sh"]
