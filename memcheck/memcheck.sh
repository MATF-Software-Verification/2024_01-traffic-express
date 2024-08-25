#!/usr/bin/bash

set -e

# Default values for options
ANNOTATE=false
KCACHEGRIND=false

# Timestamps for output files to avoid overwriting
SERVER_OUTPUT_FILE="memcheck_server_$(date +%s).out"
CLIENT1_OUTPUT_FILE="memcheck_client1_$(date +%s).out"
CLIENT2_OUTPUT_FILE="memcheck_client2_$(date +%s).out"
CLIENT3_OUTPUT_FILE="memcheck_client3_$(date +%s).out"

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
    echo "Only memcheck tool will be run."
fi

echo "Starting memcheck analysis..."

# Run the server under memcheck in the background
echo "Profiling server..."
valgrind --tool=memcheck --leak-check=full --quiet --log-file="$SERVER_OUTPUT_FILE" ../01-traffic-express/TrafficExpress/Server &
SERVER_PID=$!

# Give the server some time to start (adjust as necessary)
sleep 10

# Run the first client under memcheck in the background
echo "Profiling client 1..."
valgrind --tool=memcheck --leak-check=full --quiet --log-file="$CLIENT1_OUTPUT_FILE" ../01-traffic-express/TrafficExpress/TrafficExpress &
CLIENT1_PID=$!

# Run the second client under memcheck in the background
echo "Profiling client 2..."
valgrind --tool=memcheck --leak-check=full --quiet --log-file="$CLIENT2_OUTPUT_FILE" ../01-traffic-express/TrafficExpress/TrafficExpress &
CLIENT2_PID=$!

# Run the third client under memcheck in the background
echo "Profiling client 3..."
valgrind --tool=memcheck --leak-check=full --quiet --log-file="$CLIENT3_OUTPUT_FILE" ../01-traffic-express/TrafficExpress/TrafficExpress &
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
    echo "Running memcheck annotate (if applicable)..."
    # Note: memcheck_annotate is not a standard tool; you may want to use tools specific to memcheck output
    # For example, parse the output manually or use other tools as needed.
fi

# If the KCacheGrind option is specified, use KCacheGrind
if [ "$KCACHEGRIND" = true ]; then
    echo "Running KCacheGrind..."
    kcachegrind "$SERVER_OUTPUT_FILE" &
    kcachegrind "$CLIENT1_OUTPUT_FILE" &
    kcachegrind "$CLIENT2_OUTPUT_FILE" &
    kcachegrind "$CLIENT3_OUTPUT_FILE" &
    wait
fi

echo "Memcheck analysis completed. Output saved to ${SERVER_OUTPUT_FILE}, ${CLIENT1_OUTPUT_FILE}, ${CLIENT2_OUTPUT_FILE}, and ${CLIENT3_OUTPUT_FILE}"
