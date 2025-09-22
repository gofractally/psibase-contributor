# 0.13

- [Updates to the latest builder image that adds zlib](https://github.com/gofractally/image-builders/pull/72)

# 0.12

- [Update to the latest builder image that adds softhsm2](https://github.com/gofractally/image-builders/pull/70)

# 0.11

- Update install path for [Yarn PnP editor SDKs for VSCode](https://yarnpkg.com/getting-started/editor-sdks) in devcontainer `postCreateCommand` to restore VSCode DX after `services` directory was renamed to `packages`

# 0.10

- Install [Yarn PnP editor SDKs for VSCode](https://yarnpkg.com/getting-started/editor-sdks) in devcontainer `postCreateCommand` to restore VSCode DX

# 0.9

* [Switch rust-tools to 1.86.0 to support async-graphql@7.0.17](https://github.com/gofractally/image-builders/pull/69)
* [Remove deprecated twxs.cmake extension](https://github.com/gofractally/psibase-contributor/pull/37)

# 0.8

* [added ZipFS extension to restore VS Code DX](https://github.com/gofractally/psibase-contributor/pull/36/commits/0004449ceef6a560eb5cd24969ae1647d0ebf7e5)

# 0.7

* [Upgrade yarn to v4 and downgrade cargo-component to 0.15.0](https://github.com/gofractally/image-builders/pull/65)
* [Pin rust at v1.85](https://github.com/gofractally/image-builders/pull/66)

# 0.6

* [Downgrading yarn back to v1.22.22 (classic)](https://github.com/gofractally/image-builders/pull/64)
* [Set HOST_IP environment variable correctly on Mac](https://github.com/gofractally/image-builders/pull/59)

# 0.5

* [Upgrading yarn to Berry (4.9.1)](https://github.com/gofractally/image-builders/pull/60)
* [Lock cargo-component to v0.20.0 to avoid adapter issues on Apple Silicon](https://github.com/gofractally/image-builders/pull/60)
* [Fix default config dir](https://github.com/gofractally/image-builders/pull/58)
* [Add cargo-generate](https://github.com/gofractally/image-builders/commit/54c67673de1b230a5087ad6cfd3eefcfe5160377)

# 0.4

* [Remove old dashboard from images](https://github.com/gofractally/image-builders/pull/53)
* [Update cargo-component to v0.21.1](https://github.com/gofractally/image-builders/pull/55)
* [Update boost to v1.87.0](https://github.com/gofractally/image-builders/pull/54)
* [Set cargo-component cache dir](https://github.com/gofractally/image-builders/pull/56)

# 0.3

* Added cargo-generate v0.22.0
* Adds support for mdbook-tabs
* removes wasm32-wasi target
* Updates boost in Ubuntu 22.04 from 1.81->1.83
