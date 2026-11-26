# XPtsp OpenWrt package repository

This repository hosts prebuilt OpenWrt packages maintained by XPtsp. It includes packages in both the legacy **IPK/opkg** format and the newer **APK/apk** format. The available package sets depend on the format and target architecture.

| Format | Directories | Package manager |
|---|---|---|
| IPK | `ipk/all`, `ipk/aarch64_cortex-a53`, `ipk/x86_64` | `opkg` |
| APK | `apk/all`, `apk/aarch64_cortex-a53`, `apk/x86_64` | `apk` |

`all` contains architecture-independent packages. Architecture-specific packages are built for the target named by their directory. Check your device's OpenWrt release and package manager before adding a feed; IPK and APK feeds are not interchangeable.

## Add the IPK feed (opkg)

On the router, add the repository and its signing key, then refresh package indexes:

```sh
echo 'src/gz xptsp https://xptsp.github.io/openwrt-repo/ipk/all' >> /etc/opkg/customfeeds.conf
wget -O /tmp/openWrtUsign.pub https://xptsp.github.io/openwrt-repo/openWrtUsign.pub
opkg-key add /tmp/openWrtUsign.pub
opkg update
```

For packages built for your device's architecture, add the matching feed as well. For example, on `aarch64_cortex-a53`:

```sh
echo 'src/gz xptsp_aarch64 https://xptsp.github.io/openwrt-repo/ipk/aarch64_cortex-a53' >> /etc/opkg/customfeeds.conf
opkg update
```

Use `ipk/x86_64` instead for an x86_64 target. Install packages by name with `opkg install <package-name>`.

## Add the APK feed

OpenWrt builds using APK can configure the matching repository URL with the system's `apk` repository configuration. Add the `all` feed and, when needed, the feed for the device architecture:

```sh
echo 'https://xptsp.github.io/openwrt-repo/apk/all' >> /etc/apk/repositories
echo 'https://xptsp.github.io/openwrt-repo/apk/aarch64_cortex-a53' >> /etc/apk/repositories
apk update
```

Replace `aarch64_cortex-a53` with `x86_64` for x86_64 devices. Trust the repository's APK public key, `apk/xptsp.pem`, using the key setup required by your OpenWrt release. For example, on releases that use `/etc/apk/keys/`:

```sh
wget -O /etc/apk/keys/xptsp.pem https://xptsp.github.io/openwrt-repo/apk/xptsp.pem
```

Then refresh the index and install packages with `apk add <package-name>`.

## Use with the OpenWrt Image Builder

For Image Builder releases that use opkg, add the desired IPK feed to `repositories.conf`, and make the public key available in the builder's `keys` directory:

```text
src/gz xptsp https://xptsp.github.io/openwrt-repo/ipk/all
src/gz xptsp_aarch64 https://xptsp.github.io/openwrt-repo/ipk/aarch64_cortex-a53
```

Copy `openWrtUsign.pub` into `keys/` using the key filename expected by your Image Builder version. Include only the architecture feed that matches the target image.

## Repository contents

This repository publishes the built package files and their indexes. The package sources and build environments are maintained separately. `repoUpdate.sh` contains the maintainer's local indexing and signing workflow; its paths and signing keys are specific to that build environment.

Package availability and versions can change as feeds are updated. Refer to the package index under the matching format and architecture for the current list.

## License

Repository-level licensing information is in [LICENSE](LICENSE). Individual packages may have their own licenses and terms.
