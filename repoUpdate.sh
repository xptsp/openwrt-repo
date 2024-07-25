#!/bin/bash

# Move any new IPKs from compilation directory:
cd $(dirname $0)
ls ~/Compile/ipks/*.ipk 2> /dev/null | grep -v argon | while read FILE; do
	NAME=$(basename $FILE | cut -d_ -f 1)
	rm ${NAME}_*.ipk 2> /dev/null
	mv ${FILE} ./
done
chmod -x *.ipk

# Define the variables needed:
SCRIPT="$HOME/Compile/openwrt/scripts/ipkg-make-index.sh"
KEY="$HOME/Compile/openWrtUsign.key"

# Update the files necessary for the repo:
MKHASH="$HOME/Compile/openwrt/staging_dir/host/bin/mkhash" $SCRIPT . 2>/dev/null > Packages.manifest
grep -vE '^Require' Packages.manifest > Packages
gzip -9nc Packages > Packages.gz
usign -S -m Packages -s $KEY
