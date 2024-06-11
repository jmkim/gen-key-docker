#!/bin/bash

GGK_DOCKERNAME="$1"
GGK_HOSTDIR="$(pwd)"
GGK_WORKDIR="/root/gpg-gen-key"

docker run -itd -v "$GGK_HOSTDIR":"$GGK_WORKDIR" debian:unstable "$GGK_WORKDIR/gen-key-docker.sh" --name "$GGK_DOCKERNAME"
