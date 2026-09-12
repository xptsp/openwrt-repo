#!/bin/bash

# Move any new IPKs from compilation directory:
cd $(dirname $0)
ls ~/Compile/ipks/*.ipk 2> /dev/null | grep -v argon | while read FILE; do
	NAME=$(basename $FILE | cut -d_ -f 1)
	rm ${NAME}_*.ipk 2> /dev/null
	mv ${FILE} ./
done
chmod -Rf -x *.ipk *.spk

#############################################################################################
# Repository creation code for IPK packages
#############################################################################################
# Define the variables needed:
SCRIPT="$HOME/Compile/openwrt-24.10.8-x86/scripts/ipkg-make-index.sh"
KEY="$HOME/Compile/openWrtUsign.key"

function mkhash()
{
	MKHASH="$HOME/Compile/openwrt-24.10.8-x86/staging_dir/host/bin/mkhash" $SCRIPT $1 | tee $1/Packages.manifest;
}
function mkpackage()
{
	grep -vE '^Require' $1/Packages.manifest > $1/Packages
	gzip -9nc $1/Packages > $1/Packages.gz
	usign -S -m $1/Packages -s $KEY
}
{ mkhash ipk/all; mkhash ipk/aarch64_cortex-a53; mkhash ipk/x86_64; } 2>/dev/null > Packages.manifest
mkpackage .
mkpackage ipk/all
mkpackage ipk/aarch64_cortex-a53
mkpackage ipk/x86_64

#############################################################################################
# Repository creation code for APK packages
#############################################################################################
function apk_package()
{
	$HOME/Compile/openwrt/staging_dir/host/bin/apk mkndx --root apk --keys-dir $HOME/GitHub/Builder/keys/ \
		--sign $HOME/GitHub/Builder/keys/local-private-key.pem --output $1/packages.adb --allow-untrusted $1/*.apk
}
apk_package apk/all
apk_package apk/aarch64_cortex-a53
