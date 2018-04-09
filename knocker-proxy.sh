#!/bin/sh

host=$1
ssh_port=$2

for port in ${@:3}; do
    echo "[*] Knocking port $port/tcp..." 1>&2
    nc -z -w 1 $host $port
done

nc -z -w 1 $host $ssh_port
if [[ $? -eq 0 ]]; then
    echo -n "[*] " 1>&2
    exec nc -v $host $ssh_port
else
    echo "[*] Knock failed...please try again!" 1>&2
    exit 1
fi
