#!/bin/bash

. ./common.sh

echo vault auth prije toga

if ! vault mounts | grep "${ORG} Root CA"
then
	vault mount -path=${ORG} -description="${ORG} Root CA" -max-lease-ttl=87600h pki
fi

if ! curl -s $VAULT_ADDR/v1/${ORG}/ca/pem | openssl x509 -text
then
vault write bringout/root/generate/internal \
	common_name="${ORG} Root CA" \
	ttl=87600h \
	key_bits=4096 \
	exclude_cn_from_sans=true

vault write bringout/config/urls issuing_certificates="$VAULT_ADDR/v1/${ORG}"
fi


vault read -field=issuing_certificates ${ORG}/config/urls
