#!/bin/bash

. ./common.sh

DEPARTMENT=ops

vault mount -path=${ORG}_${DEPARTMENT} -description="${ORG} ${DEPARTMENT} Intermediate CA" \
	-max-lease-ttl=26280h pki

vault write ${ORG}_${DEPARTMENT}/intermediate/generate/internal \
    common_name="${ORG} Operations Intermediate CA" \
    ttl=26280h \
    key_bits=4096 \
    exclude_cn_from_sans=true

#vault write ${ORG}/root/sign-intermediate \
#	   csr=@${ORG}_${DEPARTMENT}.csr \
#	   common_name="${ORG} ${DEPARTMENT} Intermediate CA" \
#	   ttl=8760h

