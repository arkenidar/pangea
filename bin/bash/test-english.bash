#!/usr/bin/env bash

# Run all English (words) tests.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TESTS_DIR="$SCRIPT_DIR/../../tests/words"

# cd into the tests directory so relative file includes (e.g. ! : factorial.words) resolve correctly
cd "$TESTS_DIR"

for test_file in *.words; do
    echo "=== $test_file ==="
    "$SCRIPT_DIR/pangea.bash" "$test_file"
    echo ""
done
