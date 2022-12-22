
if ! [[ -d "$HDF5_DIR" ]]; then
    echo "HDF5_DIR '$HDF5_DIR' doesn't exist." 1>&2
    exit 1
fi

if [ "$RUNNER_OS" == "macOS" ]; then
    shared_suffix='.dylib'
elif [ "$RUNNER_OS" == "Windows" ]; then
    shared_suffix='.dll'
else
    shared_suffix='.so'
fi

if ! [[ -f "$HDF5_DIR/lib/libhdf5$shared_suffix" ]]; then
    echo "HDF5 library not found" 1&>2
    exit 1
fi