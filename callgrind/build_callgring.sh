#!/usr/bin/bash

# Path to cmake (adjust if needed)
CMAKE=/usr/bin/cmake

set -xe

# Create build directory and navigate to it
mkdir -p ../01-traffic-express/TrafficExpress/build
cd ../01-traffic-express/TrafficExpress/build

# Run cmake to configure the project and specify the Unix Makefiles generator
$CMAKE -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Debug ..



# Navigate to the directory for callgrind
cd ../../../callgrind
