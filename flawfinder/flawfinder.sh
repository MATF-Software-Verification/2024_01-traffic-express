#!/usr/bin/bash

set -xe

flawfinder --html ../01-traffic-express > flawfinder_result.html

echo "finished flawfinder"

firefox flawfinder_result.html
