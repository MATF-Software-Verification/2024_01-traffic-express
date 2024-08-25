#!/bin/bash

set -e

# Define paths
CURRENT_DIR=$(pwd)
PROJECT_DIR="${CURRENT_DIR}/../01-traffic-express/TrafficExpress/"
BUILD_DIR="${PROJECT_DIR}/build"
COMPILATION_DB="${PROJECT_DIR}/compile_commands.json"
OUTPUT_FILE="${CURRENT_DIR}/clang-tidy-output.txt"

# Function to check if a command is successful
check_success() {
    if [ $? -ne 0 ]; then
        echo "Error: $1"
        exit 1
    fi
}

# Ensure the build directory exists
echo "Creating build directory if it doesn't exist..."
mkdir -p "${BUILD_DIR}"

# Navigate to the build directory
cd "${BUILD_DIR}"

# Run CMake to generate compile_commands.json
echo "Running CMake to generate compile_commands.json..."
cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON .. || check_success "CMake failed. Check the CMake output for errors."

# Ensure compile_commands.json was created
if [ ! -f "${COMPILATION_DB}" ]; then
    echo "Error: compile_commands.json not found. Ensure that your CMakeLists.txt is correctly set up to generate it."
    exit 1
fi

# Run clang-tidy on all .cpp files in the project directory
echo "Running clang-tidy on C++ source files..."
find "${PROJECT_DIR}" -name '*.cpp' | while read -r file; do
    echo "Processing $file"
    clang-tidy "$file" -checks='-*,modernize-use-override,modernize-use-nullptr,readability-const-return-type' >> "${OUTPUT_FILE}" 2>&1
done

# Notify completion
echo "clang-tidy analysis completed. Output saved to ${OUTPUT_FILE}"
