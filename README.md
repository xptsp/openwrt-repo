# OpenWrt-repo

This is my personal repository of compiled OpenWrt packages for both "all" and "aarch64_cortex-a53" architectures.  No other architectures will be supported unless I have a personal usage case.     

## How to use:
```
echo "src/gz xptsp https://xptsp.github.io/openwrt-repo" >> /etc/opkg/customfeeds.conf
wget http://xptsp.github.io/openwrt-repo/openWrtUsign.pub
opkg-key add openWrtUsign.pub
opkg update
```

Thanks to [How to setup an OpenWrt repository](https://notes.iopush.net/blog/2017/how-to-setup-an-openwrt-repo/) for the guide!
