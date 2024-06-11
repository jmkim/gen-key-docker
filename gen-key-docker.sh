#!/bin/bash

GGK_WORKDIR="/root/gpg-gen-key"
GGK_OUTPUT_GPGDIR="$GGK_WORKDIR/output-gnupg"
GGK_OUTPUT_STDOUT="$GGK_WORKDIR/output-stdout/$(hostname)"
GGK_GPGDIR="/root/.gnupg"

touch $GGK_OUTPUT_STDOUT
if [ $? != 0 ]
then
    exit 1
fi

mkdir -p $GGK_OUTPUT_GPGDIR

apt update
apt install -y gnupg

while true
do
    rm -rf "$GGK_GPGDIR"
    gpg --list-key > /dev/null 2>&1

    # Key creation
    GPG_REVOKE_LOCATE="$(gpg --batch --gen-key gen-key-script 2>&1)"

    # Cut GPG keyID from the key creation output (revoke location msg)
    GPG_KEYID="$(echo "$GPG_REVOKE_LOCATE" | sed -z 's/\n//g' | cut -d '/' -f 8 | cut -d '.' -f 1)"

    # ID Substrings from each 4 characters
    GPG_KEYID4_1="${GPG_KEYID:0:4}"
    GPG_KEYID4_2="${GPG_KEYID:4:4}"
    GPG_KEYID4_3="${GPG_KEYID:8:4}"
    GPG_KEYID4_4="${GPG_KEYID:12:4}"
    GPG_KEYID4_5="${GPG_KEYID:16:4}"
    GPG_KEYID4_6="${GPG_KEYID:20:4}"
    GPG_KEYID4_7="${GPG_KEYID:24:4}"
    GPG_KEYID4_8="${GPG_KEYID:28:4}"
    GPG_KEYID4_9="${GPG_KEYID:32:4}"
    GPG_KEYID4_10="${GPG_KEYID:36:4}"

    # ID strings
    GPG_KEYID_LAST8="                                        $GPG_KEYID4_9 $GPG_KEYID4_10"
    GPG_KEYID_LAST16="                              $GPG_KEYID4_7 $GPG_KEYID4_8 $GPG_KEYID4_9 $GPG_KEYID4_10"
    GPG_KEYID_ALL="$GPG_KEYID4_1 $GPG_KEYID4_2 $GPG_KEYID4_3 $GPG_KEYID4_4 $GPG_KEYID4_5 $GPG_KEYID4_6 $GPG_KEYID4_7 $GPG_KEYID4_8 $GPG_KEYID4_9 $GPG_KEYID4_10"

    # Show ID strings
    echo "" >> "$GGK_OUTPUT_STDOUT"
    echo "$GPG_KEYID_LAST8" >> "$GGK_OUTPUT_STDOUT"
    echo "$GPG_KEYID_LAST16" >> "$GGK_OUTPUT_STDOUT"
    echo "$GPG_KEYID_ALL" >> "$GGK_OUTPUT_STDOUT"

    mv /root/.gnupg/ "$GGK_OUTPUT_GPGDIR/$GPG_KEYID_ALL"
done
