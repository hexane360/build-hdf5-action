#!/bin/bash
set -euo pipefail

echo "HDF5_DIR: $HDF5_DIR"
echo "hdf5-dir=$HDF5_DIR" >>"$GITHUB_OUTPUT"

echo "Installing system dependencies..."

if [ "$RUNNER_OS" == "Linux" ]; then
	sudo apt-get -y update
	sudo apt-get -y install build-essential cmake
fi

cd "$GITHUB_WORKSPACE/hdf5-build"

mkdir build
cd build

cmake .. -G "Unix Makefiles" \
         -DCMAKE_BUILD_TYPE=Release \
         -DBUILD_SHARED_LIBS=ON \
         -DBUILD_TESTING=OFF \
         -DHDF5_BUILD_TOOLS=OFF \
         -DCMAKE_INSTALL_PREFIX="$HDF5_DIR"

cmake --build . --config Release
cmake --build . --target install

