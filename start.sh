#!/usr/bin/env bash

cd ${DATA_DIR}

if [ -z "${METADATA_DIR}" ]; then
    export METADATA_DIR="."
fi
mkdir -p "${METADATA_DIR}"
# generate metadata for front- (IdP) and back-end (SP) and write it to mounted volume
make_satosa_saml_metadata.py proxy_conf.yaml -o "${METADATA_DIR}"

# start the proxy
if [[ -f https.key && -f https.crt ]]; then # if HTTPS cert is available, use it
  exec gunicorn -b0.0.0.0:${PROXY_PORT} --keyfile https.key --certfile https.crt satosa.wsgi:app
else
  exec gunicorn -b0.0.0.0:${PROXY_PORT} satosa.wsgi:app
fi
