#!/bin/bash

mkdir certs

# Generate private key
openssl genrsa -out certs/docker.lab.key 2048

# Create config file for the certificate
cat > docker.lab.conf << EOF
[req]
default_bits = 2048
prompt = no
default_md = sha256
distinguished_name = dn
x509_extensions = v3_req

[dn]
C = US
ST = State
L = City
O = Organization
OU = DevOps
CN = *.docker.lab

[v3_req]
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = *.docker.lab
DNS.2 = docker.lab
EOF

# Generate certificate
openssl req -x509 -new -nodes -key certs/docker.lab.key -sha256 -days 365 -out certs/docker.lab.crt -config docker.lab.conf

# Display certificate information
openssl x509 -in certs/docker.lab.crt -text -noout

# Generate private key
openssl genrsa -out certs/kube.lab.key 2048

# Create config file for the certificate
cat > kube.lab.conf << EOF
[req]
default_bits = 4096
prompt = no
default_md = sha256
distinguished_name = dn
x509_extensions = v3_req

[dn]
C = US
ST = State
L = City
O = Organization
OU = DevOps
CN = *.kube.lab

[v3_req]
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = *.kube.lab
DNS.2 = kube.lab
EOF

# Generate certificate
openssl req -x509 -new -nodes -key certs/kube.lab.key -sha256 -days 365 -out certs/kube.lab.crt -config kube.lab.conf

# Display certificate information
openssl x509 -in certs/kube.lab.crt -text -noout
