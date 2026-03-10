#!/usr/bin/env bash

# Run all Italian (parole) tests.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TESTS_DIR="$SCRIPT_DIR/../../tests/parole"

# cd into the tests directory so relative file includes (e.g. ! : fattoriale.parole) resolve correctly
cd "$TESTS_DIR"

for test_file in *.parole; do
    echo "=== $test_file ==="
    "$SCRIPT_DIR/pangea-italian.bash" "$test_file"
    echo ""
done
