# Packages SubModules for OpenWrt

## How to use:
```
cd openwrt
echo "src-git xptsp https://github.com/xptsp/openwrt-repo" >> feeds.conf.default
scripts/feeds update -a
scripts/feeds install -a
```

## How to clone:
```
git clone --recurse-submodules https://github.com/xptsp/openwrt-repo
```
