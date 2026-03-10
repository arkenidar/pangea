#!/usr/bin/env bash

# This file is part of Pangea, released under the MIT License (see LICENSE).
# This file is the main entry point for the Pangea script.
# It is responsible for setting up the environment and calling the appropriate functions based on user input.   

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
lua "$SCRIPT_DIR/../../src/pangea1/main.lua" "$@"