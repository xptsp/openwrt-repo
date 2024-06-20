#!/bin/bash

SCRIPT="$HOME/Compile/openwrt/scripts/ipkg-make-index.sh"
KEY="$HOME/Compile/openWrtUsign.key"

MKHASH="$HOME/Compile/openwrt/staging_dir/host/bin/mkhash" $SCRIPT . 2>/dev/null > Packages.manifest
grep -vE '^Require' Packages.manifest > Packages
gzip -9nc Packages > Packages.gz
usign -S -m Packages -s $KEY
