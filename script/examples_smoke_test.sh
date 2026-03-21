#!/usr/bin/env sh
set -eu
SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
ruby "$SCRIPT_DIR/examples_smoke_test.rb" "$@"
