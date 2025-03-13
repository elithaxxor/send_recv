#!/bin/bash

# Default port
PORT=${1:-12345}
LOG="server.log"

# Signal handling
trap "echo 'Server stopped'; exit" SIGINT SIGTERM

# Start server with parallel connections
while true; do
    echo "[$(date)] Waiting for connections on port $PORT..." | tee -a "$LOG"
    nc -l -p "$PORT" -c "
        trap 'echo \"Connection closed\"' EXIT
        read -r cmd
        case \"\$cmd\" in
            LIST)
                ls -1 | nl -w2 -s'. ' | sed 's/^/ ' || echo 'Error: Directory inaccessible'
                ;;
            GETALL)
                tar -czf - . 2>/dev/null || echo 'Error: Compression failed'
                ;;
            GET*)
                filenames=\$(echo \"\$cmd\" | cut -d' ' -f2-)
                if [ -z \"\$filenames\" ]; then
                    echo 'No files specified'
                    exit 1
                fi
                # Check file existence
                for f in \$filenames; do
                    if [ ! -e \"\$f\" ]; then
                        echo \"Error: \$f not found\"
                        exit 1
                    fi
                done
                tar -czf - \$filenames 2>/dev/null || echo 'Error: Compression failed'
                ;;
            *)
                echo 'Invalid command'
                exit 1
                ;;
        esac
    " | tee -a "$LOG" &
done
