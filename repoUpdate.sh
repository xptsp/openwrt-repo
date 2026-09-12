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
SCRIPT="$HOME/Compile/openwrt-24.10.8-x86/scripts/ipkg-make-index.sh"
KEY="$HOME/Compile/openWrtUsign.key"

function package()
{
	grep -vE '^Require' $1/Packages.manifest > $1/Packages
	gzip -9nc $1/Packages > $1/Packages.gz
	usign -S -m $1/Packages -s $KEY
}
function mkhash()
{
	MKHASH="$HOME/Compile/openwrt-24.10.8-x86/staging_dir/host/bin/mkhash" $SCRIPT $1 | tee $1/Packages.manifest;
}

# Update the files necessary for the repo:
{
	mkhash ipk/all;
	mkhash ipk/aarch64_cortex-a53;
	mkhash ipk/x86_64;
}  2>/dev/null > Packages.manifest
package .
package ipk/all
package ipk/aarch64_cortex-a53
package ipk/x86_64
