#!/bin/bash

# Get the directory where the script is run from
directory=$(pwd)

# Output file
output_file="memcheck_summary.txt"

# Clear the output file or create it if it does not exist
> "$output_file"

# Loop through all .out files in the current directory
for input_file in "$directory"/*.out; do
    # Check if there are no .out files
    if [ ! -e "$input_file" ]; then
        echo "No .out files found in directory: $directory" | tee -a "$output_file"
        exit 1
    fi

    echo "Processing file: $input_file" | tee -a "$output_file"

    # Extract Invalid read issues
    echo "### Invalid Read Issues in $input_file ###" | tee -a "$output_file"
    grep "Invalid read of size" "$input_file" | while read -r line; do
        echo "$line" | tee -a "$output_file"
        # Extract address and size information
        address=$(echo "$line" | awk -F 'Address ' '{print $2}' | awk '{print $1}')
        size=$(echo "$line" | grep -oP 'Invalid read of size \K[0-9]+')

        echo "Address: $address" | tee -a "$output_file"
        echo "Size: $size" | tee -a "$output_file"
        echo | tee -a "$output_file"
    done

    # Extract memory leaks
    echo "### Memory Leak Issues in $input_file ###" | tee -a "$output_file"
    grep "bytes in 1 blocks are" "$input_file" | while read -r line; do
        echo "$line" | tee -a "$output_file"

        # Extract leak size and location
        size=$(echo "$line" | awk '{print $1}')
        location=$(echo "$line" | grep -oP 'at \K.*')

        echo "Size: $size bytes" | tee -a "$output_file"
        echo "Location: $location" | tee -a "$output_file"
        echo | tee -a "$output_file"
    done

    echo "### Summary of Findings for $input_file ###" | tee -a "$output_file"

    # Count the number of invalid reads
    invalid_reads=$(grep -c "Invalid read of size" "$input_file")
    echo "Total Invalid Reads: $invalid_reads" | tee -a "$output_file"

    # Count the number of memory leaks
    memory_leaks=$(grep -c "bytes in 1 blocks are" "$input_file")
    echo "Total Memory Leaks: $memory_leaks" | tee -a "$output_file"

    echo "-----------------------------------------" | tee -a "$output_file"
done

exit 0
