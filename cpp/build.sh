#!/bin/bash

set -euo pipefail

mkdir -p build && cd build

# Configure
cmake -DCODE_COVERAGE=ON -DCMAKE_BUILD_TYPE=Debug ..
# Build (for Make on Unix equivalent to `make -j $(nproc)`)
cmake --build . --config Debug -- -j $(nproc)
# Test
ctest -j $(nproc) --output-on-failure
# Generate coverage report
gcovr -r ./ --exclude-unreachable-branches  -x -o coverage.xml
mkdir -p htmlcov
gcovr -r ./ --html --html-details -o htmlcov/index.html
