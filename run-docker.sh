#!/bin/bash

GGK_DOCKERNAME="$1"
GGK_HOSTDIR="$(pwd)"
GGK_WORKDIR="/root/gpg-gen-key"

if [ $# -eq 0 ]
then
    echo "Usage: $0 [container_name]"
    exit 1
fi

docker run -itd -v "$GGK_HOSTDIR":"$GGK_WORKDIR" --name "$GGK_DOCKERNAME" debian:unstable "$GGK_WORKDIR/gen-key-docker.sh"
