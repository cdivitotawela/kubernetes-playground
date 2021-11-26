#!/bin/bash
# Utility to generate the TLS self-signed certificate

# Web server host
CN='web.kube.play'

# TLS files
KEY="${CN}-key.pem"
CSR="${CN}.csr"
CRT="${CN}.crt"

NAMESPACE='ingress'

# Generate key
openssl  genrsa -out $KEY 2048

# Generate key and request
openssl  req -new -key $KEY -out $CSR <<EOF
AU
Queensland
Brisbane
Playground
Kubernetes
web.kube.play
admin@kube.play


EOF

# Sign request with same key (self signed certificate)
openssl  x509 -req -days 365 -in $CSR -signkey $KEY -out $CRT

# Create kubernetes secret
kubectl --namespace $NAMESPACE create secret tls certificate \
  --cert=web.kube.play.crt \
  --key=web.kube.play-key.pem