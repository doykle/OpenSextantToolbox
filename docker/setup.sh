#!/bin/sh
#
# Copy Docker setup information to a separate directory.
# This is intended to enable automated build setups by providing a
# version for the built container.  This also provides a location to
# dynamically create files.
#
# Run this script from the directory that will receive the Dockerfile
# and other container build artifacts, which may or may not be the
# directory containing the script.  For instance:
#
# mkdir build
# cd build
# sh ../setup.sh
#
# The script may take a single command-line parameter, which is the
# build number from the build automation system.

set -e

# Directory containing this script
D=$(cd $(dirname "$0") && pwd -P)
# Output directory
O=$(pwd -P)
# Build number
B=${1:-0}

echo "2.2.3-$B" > "$O/container-version"
if [ "$D" != "$O" ]; then
    cp -a "$D/Dockerfile" "$O"
fi

exit 0
