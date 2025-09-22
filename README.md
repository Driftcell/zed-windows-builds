# Unofficial builds of Zed for Windows & Remote Server

[![Test Scripts](https://github.com/deevus/zed-windows-builds/actions/workflows/test.yml/badge.svg)](https://github.com/deevus/zed-windows-builds/actions/workflows/test.yml)
[![Test Integration](https://github.com/deevus/zed-windows-builds/actions/workflows/test-integration.yml/badge.svg)](https://github.com/deevus/zed-windows-builds/actions/workflows/test-integration.yml)
[![Scheduled Nightly Build](https://github.com/deevus/zed-windows-builds/actions/workflows/nightly.yml/badge.svg)](https://github.com/deevus/zed-windows-builds/actions/workflows/nightly.yml)
[![Scheduled Stable Build](https://github.com/deevus/zed-windows-builds/actions/workflows/stable.yml/badge.svg)](https://github.com/deevus/zed-windows-builds/actions/workflows/stable.yml)

**NOTE: This is not a support channel for Zed on Windows.**

This repository provides automated builds for:
- **Zed editor for Windows** (builds are for those who want to live on the bleeding edge or just want to test Zed out on Windows)
- **Zed remote server for Linux** (for remote development scenarios)

Any issues with the Windows build should go through official channels, as this repository does not concern itself with the source code of Zed or issues found therein. 

If you have suggestions for improvements to the build process, please start a discussion or make a PR. 

All installation instructions below require that [Scoop](https://scoop.sh/) is installed on your system.

## Stable builds

```pwsh
scoop bucket add extras
scoop install extras/zed
```

## Nightly builds

```pwsh
scoop bucket add versions
scoop install versions/zed-nightly
```

## Vulkan doesn't work for you?

Install the OpenGL version

### Stable OpenGL version

```pwsh
scoop bucket add extras
scoop install extras/zed-opengl
```

### Nightly OpenGL version

```pwsh
scoop bucket add versions
scoop install versions/zed-opengl-nightly
```

## Remote Server for Linux

Each release also includes a Linux build of the Zed remote server (`zed-remote-server-linux`) for remote development scenarios. 

### Manual Installation

Download the `zed-remote-server-linux` binary from the [releases page](../../releases) and install it:

```bash
# Download and install to standard path
mkdir -p ~/.zed_server
wget https://github.com/Driftcell/zed-windows-builds/releases/latest/download/zed-remote-server-linux -O ~/.zed_server/zed-remote-server-linux
chmod +x ~/.zed_server/zed-remote-server-linux
```

The remote server follows the build steps from the official Zed documentation:
1. Install Rust & build tools (Ubuntu/Debian)
2. Clone Zed & build remote server with `cargo build -p remote_server --release`
3. Package binary and upload to release artifacts

### For Windows 10 users

Zed may not start unless you install the [Microsoft Visual C++ Redistributable 2022](https://learn.microsoft.com/en-us/cpp/windows/latest-supported-vc-redist?view=msvc-170#visual-studio-2015-2017-2019-and-2022) package. If you are using Scoop, you can install it using the following command:

```pwsh
scoop bucket add extras
scoop install vcredist2022
```

## Updates

```pwsh
# Stable version
scoop update zed
# Stable OpenGL version
scoop update zed-opengl
# Nightly version
scoop update zed-nightly
# Nightly OpenGL version
scoop update zed-opengl-nightly
```

## Is it safe?

This repository is just a [simple GitHub workflow](./.github/workflows/build.yml) that builds Zed from `main` and publishes a release every night at UTC+0000. (Additionally on push for testing).

See the [Zed homepage](https://zed.dev/) or [official repository](https://github.com/zed-industries/zed) for more details.

## Build Process

The build process is designed to be robust and handle partial failures gracefully:

- **Resilient Builds**: If one build variant (Vulkan or OpenGL) fails, the other will still complete and create a release
- **Comprehensive Testing**: All build scripts are thoroughly tested with automated test suites
- **Quality Assurance**: Each release includes SHA256 checksums for integrity verification

### Testing

The build and release scripts are automatically tested with every change:

- **Script Tests**: Unit tests for the release preparation logic
- **Integration Tests**: End-to-end testing of the build and release workflows
- **Failure Scenarios**: Testing of partial build failures to ensure robust handling

See the [scripts directory](./scripts/) for more details about the testing infrastructure.
