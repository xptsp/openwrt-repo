# XPtsp's Personal OpenWrt Repo

This is my personal repository of compiled OpenWrt packages for both "all" and "aarch64_cortex-a53" architectures.  No other architectures will be supported unless I have a personal need for other architectures.     

All packages, with exception of AdGuardHome, were built against either OpenWrt 23.05.4 or 22.03.6 SDK.  The AdGuardHome package was downloaded from the [OpenWrt snapshots for aarch64_cortex-a53 architechure](https://downloads.openwrt.org/snapshots/packages/aarch64_cortex-a53/) directory. 

All source for packages (except for AdGuardHome and argon-related packages) are submodules in the [src](https://github.com/xptsp/openwrt-repo/tree/main/src) directory. 

## Included packages

| Package | Description |
|---------|-------------|
| [adguardhome](https://github.com/openwrt/packages/tree/master/net/adguardhome) | Blocks ads and trackers on all devices in your home network. |
| [bcrypt-tool](https://github.com/xptsp/openwrt-bcrypt-tool) | bcrypt-tool is a dandy CLI tool for generating and matching bcrypt hashes |
| [e2guardian](https://github.com/xptsp/openwrt-e2guardian) | e2guardian for OpenWrt compiled with MITM and ICAP support | 
| [luci-app-argon-config](https://github.com/jerrykuku/luci-app-argon-config/tree/49501a769f130d400f25a9c58754d7a5dbc48a53) | Argon Theme Config Plugin |
| [luci-app-adguardhome](https://github.com/xptsp/luci-app-adguardhome) | Package for luci-app-adguardhome for OpenWRT |
| [luci-app-nodogsplash](https://github.com/xptsp/luci-app-nodogsplash) | Package for luci-app-nodogsplash for OpenWRT |
| [luci-app-squid-adv](https://github.com/xptsp/luci-app-squid-adv) | Maybe the best LuCI package to configure Squid? |
| [luci-mod-listening-ports](https://github.com/xptsp/luci-mod-listening-ports) | LuCI app to show Server Listening Ports |
| [luci-theme-argon](https://github.com/jerrykuku/luci-theme-argon/tree/f2eb62b34b6be806297ec69dbda7ffb96e16a566) | Argon is a clean and tidy OpenWrt LuCI theme |
| [peanut](https://github.com/xptsp/openwrt-peanut) | Script that lists the IPv4 and IPv6 connections the server is listening on |
| [privoxy-blocklist](https://github.com/xptsp/openwrt-privoxy-blocklist) | Privoxy-Blocklist script for OpenWrt |
| [saned-initd](https://github.com/xptsp/openwrt-saned-initd) | init.d script for SANED |
| [ympd](https://github.com/xptsp/openwrt-ympd) | Package to build ympd for OpenWRT |
| [luci-app-ympd](https://github.com/xptsp/luci-app-ympd) | Package for luci-app-ympd for OpenWRT |

## Instructions

### How to use on a live system:
```
echo "src/gz xptsp https://xptsp.github.io/openwrt-repo" >> /etc/opkg/customfeeds.conf
wget http://xptsp.github.io/openwrt-repo/openWrtUsign.pub
opkg-key add openWrtUsign.pub
opkg update
```

### How to use with OpenWrt Image Builder:
```
echo "src/gz xptsp https://xptsp.github.io/openwrt-repo" >> repositories.conf
wget http://xptsp.github.io/openwrt-repo/openWrtUsign.pub -O keys/3cbcafe52ad71bae
```

### How to use with OpenWrt SDK:
```
cd openwrt
echo "src-git xptsp https://github.com/xptsp/openwrt-repo" >> feeds.conf.default
scripts/feeds update -a
scripts/feeds install -a
```

### How to clone with all submodules:
```
git clone --recurse-submodules https://github.com/xptsp/openwrt-repo
```

Thanks to [How to setup an OpenWrt repository](https://notes.iopush.net/blog/2017/how-to-setup-an-openwrt-repo/) for the guide!
