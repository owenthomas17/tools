#!/bin/bash

ROOT_CA_KEY_FILENAME="rootCA.key"
ROOT_CA_KEY_LENGTH="4096"
ROOT_CA_KEY_ENCRYPTION_CYPHER="-aes256"
ROOT_CA_CERT_FILENAME="rootCA.crt"
ROOT_CA_FILE_DIRECTORY="certs"

function generateCAPrivateKey {
	echo "Trying to generate CA private key"
	if [ ! -f "${ROOT_CA_KEY_FILENAME}" ]; then
		openssl genrsa "${ROOT_CA_KEY_ENCRYPTION_CYPHER}" -out "${ROOT_CA_KEY_FILENAME}" "${ROOT_CA_KEY_LENGTH}"
	else
		echo "${ROOT_CA_KEY_FILENAME} already exists.."
	fi
}

function generateCACertificate {
	if [ ! -f "${ROOT_CA_CERT_FILENAME}" ]; then
		openssl req -x509 -new -nodes \
      -key "${ROOT_CA_KEY_FILENAME}" -subj "/CN=rootCA/C=GB/L=LONDON" \
      -days 1825 -out "${ROOT_CA_CERT_FILENAME}"
	else
		echo "${ROOT_CA_CERT_FILENAME} already exists.."
	fi

}

function main {
	mkdir -p "${ROOT_CA_FILE_DIRECTORY}"
	cd ${ROOT_CA_FILE_DIRECTORY} || exit 
	generateCAPrivateKey
	generateCACertificate
}

main
