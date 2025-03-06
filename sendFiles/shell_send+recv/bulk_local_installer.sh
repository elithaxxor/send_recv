#!/bin/bash 

# Default port
PORT=${1:-12345}

# Start the server
while true; do
    echo "[!] Waiting for a connection on port $PORT..."
    nc -l -p "$PORT" -c "
        read -r cmd
        case \"\$cmd\" in
            LIST)
                # Send numbered list of files
                ls -1 | nl -w2 -s'. ' | sed 's/^/ /'
                ;;
            GETALL)
                # Send entire directory as tar.gz
                tar -czf - .
                ;;
            GET*)
                # Extract filenames and send as tar.gz
                filenames=\$(echo \"\$cmd\" | cut -d' ' -f2-)
                if [ -z \"\$filenames\" ]; then
                    echo 'No files specified'
                    exit 1
                fi
                tar -czf - \$filenames 2>/dev/null || echo 'Error: One or more files not found'
                ;;
            *)
                echo 'Invalid command'
                ;;
        esac
    "
done
