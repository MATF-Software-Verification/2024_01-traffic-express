#!/usr/bin/bash

set -e

# Default values for options
OUTPUT_FILE="cppcheck_output_$(date +%s).txt"
XML_OUTPUT_FILE="cppcheck_output_$(date +%s).xml"
DISABLE_HTML=false

# Check command-line arguments
while getopts ":o:n" opt; do
    case ${opt} in
        o )
            OUTPUT_FILE=$OPTARG
            ;;
        n )
            DISABLE_HTML=true
            ;;
        \? )
            echo "Usage: $0 [-o output_file] [-n] source1 [source2 ...]"
            exit 1
            ;;
    esac
done

shift $((OPTIND -1))

# Print usage if no arguments are provided
if [ $# -eq 0 ]; then
    echo "Error: No source directories or files specified."
    echo "Usage: $0 [-o output_file] [-n] source1 [source2 ...]"
    exit 1
fi

echo "Starting cppcheck analysis..."

# Run cppcheck and generate XML report
SOURCE_FILES="$@"
cppcheck --enable=all --inconclusive --std=c++17 --force --xml --xml-version=2 $SOURCE_FILES 2> "$XML_OUTPUT_FILE"

# Generate text output
cppcheck --enable=all --inconclusive --std=c++17 --force $SOURCE_FILES 2> "$OUTPUT_FILE"

# Check if HTML report generation is enabled
if [ "$DISABLE_HTML" = false ]; then
    echo "Generating HTML report..."
    cppcheck-htmlreport --file="$XML_OUTPUT_FILE" --report-dir="cppcheck_report" --source-dir="."
    echo "HTML report generated in 'cppcheck_report' directory."
fi

echo "Cppcheck analysis completed. Results saved to '$OUTPUT_FILE', XML report saved to '$XML_OUTPUT_FILE'."
