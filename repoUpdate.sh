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
	pushd $1 > /dev/null
	MKHASH="$HOME/Compile/openwrt-24.10.8-x86/staging_dir/host/bin/mkhash" $SCRIPT . | tee Packages.manifest | sed "s|Filename: |Filename: $1|g";
	mkpackage $1
	popd > /dev/null
}
function mkpackage()
{
	pushd $1 > /dev/null
	grep -vE '^Require' Packages.manifest > Packages
	gzip -9nc Packages > Packages.gz
	usign -S -m Packages -s $KEY
	popd > /dev/null
}
{ mkhash ipk/all; mkhash ipk/aarch64_cortex-a53; mkhash ipk/x86_64; } 2>/dev/null > Packages.manifest
mkpackage .

#############################################################################################
# Repository creation code for APK packages
#############################################################################################
function apk_package()
{
	$HOME/Compile/openwrt/staging_dir/host/bin/apk mkndx --root $1 --keys-dir $HOME/GitHub/Builder/keys/ \
		--sign $HOME/GitHub/Builder/keys/local-private-key.pem --output $1/packages.adb --allow-untrusted $1/*.apk
}
apk_package apk/all
apk_package apk/aarch64_cortex-a53
