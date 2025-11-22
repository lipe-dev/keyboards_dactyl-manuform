#!/bin/bash
# Watch run_config.json and regenerate on changes

CONFIG="/app/src/run_config.json"
LAST_HASH=""

echo "Watching for changes to run_config.json..."
echo "Press Ctrl+C to stop"

while true; do
    CURRENT_HASH=$(md5sum "$CONFIG" 2>/dev/null | cut -d' ' -f1)

    if [ "$CURRENT_HASH" != "$LAST_HASH" ] && [ -n "$CURRENT_HASH" ]; then
        if [ -n "$LAST_HASH" ]; then
            echo ""
            echo "=== Change detected, regenerating... ==="
            cd /app/src && python3 dactyl_manuform.py
            echo "=== Done! ==="
        fi
        LAST_HASH="$CURRENT_HASH"
    fi

    sleep 1
done
