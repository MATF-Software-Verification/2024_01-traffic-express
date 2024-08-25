#!/bin/bash

for file in memcheck_*.out; do
    echo "Analyzing $file..."
    grep -E 'LEAK SUMMARY|ERROR SUMMARY' "$file"
done
