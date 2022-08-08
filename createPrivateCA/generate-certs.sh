#!/bin/bash

DOMAIN=example.net
DEFAULT_BIT_LENGTH="4096"

function createCertConfig {
	local COMMON_NAME=$1
	cat > public/"${COMMON_NAME}".cnf << EOF
[ req ]
default_bits = "${DEFAULT_BIT_LENGTH}"
prompt = no
default_md = sha256
req_extensions = req_ext
distinguished_name = dn

[ dn ]
C = GB
ST = Sussex
L = London
O = thommo
OU = "${COMMON_NAME}"
CN = "${COMMON_NAME}.${DOMAIN}"

[ req_ext ]
subjectAltName = @alt_names

[ alt_names ]
DNS.1 = "${COMMON_NAME}"
DNS.2 = "${COMMON_NAME}.${DOMAIN}"
EOF
}

function createCSR {
  local CSR_TYPE=$1
	openssl genrsa -out public/"${CSR_TYPE}".key "${DEFAULT_BIT_LENGTH}"
	openssl req -new -key public/"${CSR_TYPE}".key -out public/"${CSR_TYPE}".csr -config public/"${CSR_TYPE}".cnf
}

function createCert {
	local COMMON_NAME=$1
	createCertConfig "${COMMON_NAME}"
	createCSR "${COMMON_NAME}"
}

function signCert {
	local COMMON_NAME=$1
	openssl x509 -req -in public/"${COMMON_NAME}".csr -CA ca/rootCA.crt -CAkey ca/rootCA.key \
	-CAcreateserial -out public/"${COMMON_NAME}".crt -days 10000 \
	-extfile public/"${COMMON_NAME}".cnf -extensions req_ext
}

function main {
	mkdir -p certs/public
	cd certs || exit 1
	for CN in client server; do
		createCert $CN
		signCert $CN
	done
}

main
