#!/bin/bash
# stop script on error
set -e

THING_NAME=$1
THING_ENDPOINT=$2

python3 -m venv venv --system-site-packages

if [ $(python3 openssl.py) == "true" ]
then

echo OpenSSL is enabled.
./venv/bin/pip install -r requirements.txt
echo "thing name: ${THING_NAME} thing endpoint: ${THING_ENDPOINT}"
./venv/bin/python bootstrap.py -e ${THING_ENDPOINT} -r ../root-ca-cert.pem -c ../${THING_NAME}-certificate.pem -k ../${THING_NAME}-keypair-private.pem -m subscribe -t bootstrap

else
echo ERROR: OpenSSL is required fro IOT TLS.
exit 0
fi
