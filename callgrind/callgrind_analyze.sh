#!/bin/bash

# Directory where the script is run from (current directory)
current_directory=$(pwd)

# Find all .out files in the current directory
for file in "$current_directory"/*.out; do
    # Check if the file exists (to handle the case where no .out files are found)
    if [ -e "$file" ]; then
        echo "Opening $file with KCachegrind..."
        # Open the Callgrind file with KCachegrind
        kcachegrind "$file"
    else
        echo "No Callgrind output files found."
    fi
done
