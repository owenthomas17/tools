#!/bin/bash

function createCertConfig {
	local CERT_TYPE=$1
	cat > "${CERT_TYPE}".cnf << EOF
[ req ]
default_bits = 4096
prompt = no
default_md = sha256
req_extensions = req_ext
distinguished_name = dn

[ dn ]
C = GB
ST = Sussex
L = London
O = thommo
OU = "${CERT_TYPE}"
CN = "${CERT_TYPE}.example.net"

[ req_ext ]
subjectAltName = @alt_names

[ alt_names ]
DNS.1 = "${CERT_TYPE}"
DNS.2 = "${CERT_TYPE}.example.net"
EOF
}

function createCSR {
  local CSR_TYPE=$1
	openssl genrsa -out "${CSR_TYPE}".key 2048
	openssl req -new -key "${CSR_TYPE}".key -out "${CSR_TYPE}".csr -config "${CSR_TYPE}".cnf
}

function createCert {
	local CERT_TYPE=$1
	createCertConfig "${CERT_TYPE}"
	createCSR "${CERT_TYPE}"
}

function signCert {
	local CERT_TYPE=$1
	openssl x509 -req -in "${CERT_TYPE}".csr -CA rootCA.crt -CAkey rootCA.key \
	-CAcreateserial -out "${CERT_TYPE}".crt -days 10000 \
	-extfile "${CERT_TYPE}".cnf
}

function main {
	mkdir -p certs
	cd certs || exit 1
	for cert in client server; do
		createCert $cert
		signCert $cert
	done
}

main
