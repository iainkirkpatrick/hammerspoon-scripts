#!/bin/bash
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "watching ${CURRENT_DIR} for file changes, will run setup.sh on change"
fswatch -o ${CURRENT_DIR} | xargs -n1 ${CURRENT_DIR}/setup.sh
