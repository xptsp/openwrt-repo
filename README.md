# XPtsp's Personal OpenWrt Repo

This is my personal repository of compiled OpenWrt packages for both "all" and "aarch64_cortex-a53" architectures.  No other architectures will be supported unless I have a personal need for other architectures.     

## How to use on a live system:
```
echo "src/gz xptsp https://xptsp.github.io/openwrt-repo" >> /etc/opkg/customfeeds.conf
wget http://xptsp.github.io/openwrt-repo/openWrtUsign.pub
opkg-key add openWrtUsign.pub
opkg update
```

## How to use with OpenWrt SDK:
```
cd openwrt
echo "src-git xptsp https://github.com/xptsp/openwrt-repo" >> feeds.conf.default
scripts/feeds update -a
scripts/feeds install -a
```

## How to clone with all submodules:
```
git clone --recurse-submodules https://github.com/xptsp/openwrt-repo
```

Thanks to [How to setup an OpenWrt repository](https://notes.iopush.net/blog/2017/how-to-setup-an-openwrt-repo/) for the guide!
