#!/bin/bash


## TODO: Get user input for server address and port
# Default connection parameters
SERVER_ADDRESS=${1:-192.168.1.112}
PORT=${2:-12345}

send_command() {
    nc "$SERVER_ADDRESS" "$PORT" <<< "$1"
}

list_files() {
    echo -e "\nServer directory contents:"
    send_command "LIST" | while read -r line; do
        echo "  $line"
    done
}

download_files() {
    echo -e "\nEnter file numbers (e.g., 1 3 5 or 1-5) or 'all':"
    read -r selection
    echo

    if [[ "$selection" == "all" ]]; then
        echo "Downloading entire directory..."
        send_command "GETALL" | tar -xzvf -
    else
        declare -a file_array
        mapfile -t file_array < <(send_command "LIST" | awk '{print $2}')
        
        # Process number ranges
        expanded_selection=()
        for part in $selection; do
            if [[ $part =~ ^([0-9]+)-([0-9]+)$ ]]; then
                for ((i=${BASH_REMATCH[1]};i<=${BASH_REMATCH[2]};i++)); do
                    expanded_selection+=("$i")
                done
            else
                expanded_selection+=("$part")
            fi
        done

        # Validate and collect filenames
        echo "[+] Validating, and fetching files."
        valid_files=()
        for num in "${expanded_selection[@]}"; do
            index=$((num - 1))
            if [ "$index" -ge 0 ] && [ "$index" -lt "${#file_array[@]}" ]; then
                valid_files+=("${file_array[$index]}")
				echo "  [+] ${valid_files} -- [ADDED]"
            else
                echo "[-] Warning: Invalid number $num -- [NOT ADDED]"
            fi
        done

        if [ ${#valid_files[@]} -gt 0 ]; then
            echo "[!]Downloading selected files..."
            send_command "GET ${valid_files[*]}" | tar -xzvf -
        else
            echo "[!]No valid files selected"
        fi
    fi
}

# Main interface
while true; do
    echo -e "\nOptions:"
    echo "1. List files"
    echo "2. Download files"
    echo "3. Exit"
    read -rp "Choose an option (1-3): " choice

    case $choice in
        1) list_files ;;
        2) download_files ;;
        3) exit 0 ;;
        *) echo "Invalid choice" ;;
    esac
done
