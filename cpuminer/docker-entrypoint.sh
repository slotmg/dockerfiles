#!/bin/bash
# SLot <slotmg@protonmail.com>
set -e 
#[ -z "${SEUEMAIL}" ] && { echo "Tatu, passe a variavel SEUEMAIL=seuemail@blabla.com"; exit 1; }
if [[ -z "${SEUEMAIL}" ]] ; then
	echo "Tatu, passe a variavel SEUEMAIL=seuemail@blablalba.com"
	exit 1
fi
./opt/cpuminer-multi/minerd -a cryptonight -o stratum+tcp://xmr.pool.minergate.com:45560 -u ${SEUEMAIL} -p x
