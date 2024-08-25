#!/usr/bin/bash

set -e

# Default values for options
ANNOTATE=false
KCACHEGRIND=false

# Timestamps for output files to avoid overwriting
SERVER_OUTPUT_FILE="callgrind_server_$(date +%s).out"
CLIENT1_OUTPUT_FILE="callgrind_client1_$(date +%s).out"
CLIENT2_OUTPUT_FILE="callgrind_client2_$(date +%s).out"
CLIENT3_OUTPUT_FILE="callgrind_client3_$(date +%s).out"

CMAKE=/usr/bin/cmake

# Check command-line arguments
if [ $# -lt 0 ]; then
    echo "Error: Insufficient arguments. Usage: $0 [-a] [-k]"
    exit 1
fi

if [ "$1" = "-a" ] && [ "$2" = "-k" ]; then
    ANNOTATE=true
    KCACHEGRIND=true
elif [ "$1" = "-k" ]; then
    KCACHEGRIND=true
elif [ "$1" = "-a" ]; then
    ANNOTATE=true
else
    echo "Only callgrind tool will be run."
fi

echo "Starting callgrind analysis..."

# Run the server under callgrind in the background
echo "Profiling server..."
valgrind --tool=callgrind --quiet --callgrind-out-file="$SERVER_OUTPUT_FILE" ../01-traffic-express/TrafficExpress/Server &
SERVER_PID=$!

# Give the server some time to start (adjust as necessary)
sleep 10

# Run the first client under callgrind in the background
echo "Profiling client 1..."
valgrind --tool=callgrind --quiet --callgrind-out-file="$CLIENT1_OUTPUT_FILE" ../01-traffic-express/TrafficExpress/TrafficExpress &
CLIENT1_PID=$!

# Run the second client under callgrind in the background
echo "Profiling client 2..."
valgrind --tool=callgrind --quiet --callgrind-out-file="$CLIENT2_OUTPUT_FILE" ../01-traffic-express/TrafficExpress/TrafficExpress &
CLIENT2_PID=$!

# Run the third client under callgrind in the background
echo "Profiling client 3..."
valgrind --tool=callgrind --quiet --callgrind-out-file="$CLIENT3_OUTPUT_FILE" ../01-traffic-express/TrafficExpress/TrafficExpress &
CLIENT3_PID=$!

# Wait for all client processes to complete
wait $CLIENT1_PID
wait $CLIENT2_PID
wait $CLIENT3_PID

# Terminate the server process if it is still running
if ps -p $SERVER_PID > /dev/null; then
    echo "Terminating the server process..."
    kill $SERVER_PID
    # Wait for the server to terminate and handle potential issues
    if ! wait $SERVER_PID; then
        echo "Server did not terminate cleanly."
        # Optionally, force termination if it didn't exit cleanly
        kill -9 $SERVER_PID
    fi
fi

# If the annotate option is specified, use callgrind_annotate
if [ "$ANNOTATE" = true ]; then
    echo "Running callgrind annotate..."
    callgrind_annotate "$SERVER_OUTPUT_FILE" > "annotate_$SERVER_OUTPUT_FILE"
    callgrind_annotate "$CLIENT1_OUTPUT_FILE" > "annotate_$CLIENT1_OUTPUT_FILE"
    callgrind_annotate "$CLIENT2_OUTPUT_FILE" > "annotate_$CLIENT2_OUTPUT_FILE"
    callgrind_annotate "$CLIENT3_OUTPUT_FILE" > "annotate_$CLIENT3_OUTPUT_FILE"
fi

# If the KCacheGrind option is
