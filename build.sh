#!/bin/bash
set -euo pipefail

echo "HDF5_DIR: $HDF5_DIR"

echo "Installing system dependencies..."

if [ "$RUNNER_OS" == "Linux" ]; then
	sudo apt-get -y update
	sudo apt-get -y install build-essential cmake zlib1g-dev
elif [ "$RUNNER_OS" == "macOS" ]; then
	# don't reinstall cmake & zlib on GitHub CI runner
	if [ -z "$RUNNER_TOOL_CACHE" ]; then
		HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=1 brew install cmake zlib
	fi
fi

cd "$GITHUB_WORKSPACE/hdf5-build"

mkdir build && cd build

cmake .. -G "Unix Makefiles" \
         -DCMAKE_BUILD_TYPE=Release \
         -DBUILD_SHARED_LIBS=ON \
         -DBUILD_TESTING=OFF \
         -DHDF5_BUILD_TOOLS=OFF \
         -DCMAKE_INSTALL_PREFIX="$HDF5_DIR"

cmake --build . --config Release
sudo cmake --build . --target install

