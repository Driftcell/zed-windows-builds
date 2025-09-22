#!/bin/bash

# Script to prepare release files from build artifacts
# This script handles both Vulkan and OpenGL builds, creating releases even if one fails

set -euo pipefail

ARTIFACTS_DIR="artifacts"
RELEASE_DIR="release"

# Create release directory
mkdir -p "$RELEASE_DIR"

# Check if Vulkan build exists
if [ -f "$ARTIFACTS_DIR/zed-release/zed.exe" ]; then
    echo "Found Vulkan build, adding to release..."
    mv "$ARTIFACTS_DIR/zed-release/zed.exe" "$RELEASE_DIR/zed.exe"
    zip -j "$RELEASE_DIR/zed.zip" -9 "$RELEASE_DIR/zed.exe"
fi

# Check if remote server build exists
if [ -f "$ARTIFACTS_DIR/remote-server-release/zed-remote-server-linux" ]; then
    echo "Found remote server build, adding to release..."
    mv "$ARTIFACTS_DIR/remote-server-release/zed-remote-server-linux" "$RELEASE_DIR/zed-remote-server-linux"
    zip -j "$RELEASE_DIR/zed-remote-server-linux.zip" -9 "$RELEASE_DIR/zed-remote-server-linux"
fi

# Generate checksums for existing files in release folder
cd "$RELEASE_DIR"
if ls * >/dev/null 2>&1; then
    echo "Generating checksums..."
    sha256sum * > sha256sums.txt
    echo "Release files prepared successfully:"
    ls -la
else
    echo "Error: No release files found in release folder"
    exit 1
fi
