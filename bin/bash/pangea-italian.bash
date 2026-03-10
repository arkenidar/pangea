#!/usr/bin/env bash

# This file is part of Pangea, released under the MIT License (see LICENSE).

# This file is used to set the Italian locale for Pangea.
# It is sourced by the main Pangea script when the user selects Italian as their language.
# Set the locale to Italian
export LC_ALL=it_IT.UTF-8
export LANG=it_IT.UTF-8
export LANGUAGE=it_IT.UTF-8

# Call the main Pangea script with the Italian locale
# args are passed to the main Pangea script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
"$SCRIPT_DIR/pangea.bash" italian "$@"
