#!/usr/bin/env bash

cd ${DATA_DIR}

# generate metadata for front- (IdP) and back-end (SP) and write it to mounted volume
make_satosa_saml_metadata.py proxy_conf.yaml

# start the proxy
if [[ -f https.key && -f https.crt ]]; then # if HTTPS cert is available, use it
  exec gunicorn -b0.0.0.0:${PROXY_PORT} --keyfile https.key --certfile https.crt satosa.wsgi:app
else
  exec gunicorn -b0.0.0.0:${PROXY_PORT} satosa.wsgi:app
fi
