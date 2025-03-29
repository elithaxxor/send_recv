#!/bin/bash

# Default connection parameters
SERVER=${1:-localhost}
PORT=${2:-12345}

# Array to store the file list
file_array=()

# Function to send a command to the server
send_command() {
    local cmd="$1"
    echo "$cmd" | nc "$SERVER" "$PORT"
}

# Function to list files from the server
list_files() {
    local output
    output=$(send_command "LIST")
    if [ -n "$output" ]; then
        echo "Server directory contents:"
        echo "$output"
        mapfile -t file_array <<< "$output"
    else
        echo "Failed to retrieve file list or server directory is empty."
    fi
}

# Function to handle download responses
handle_download() {
    local cmd="$1"
    local temp_file
    temp_file=$(mktemp)
    send_command "$cmd" > "$temp_file"
    if head -n1 "$temp_file" | grep -qE "^(Error:|Invalid)"; then
        cat "$temp_file"
        rm "$temp_file"
    else
        echo "Enter output filename (e.g., archive.tar.gz):"
        read -r output_file
        if [ -n "$output_file" ]; then
            mv "$temp_file" "$output_file"
            echo "Saved to $output_file"
        else
            echo "No filename provided, discarding download."
            rm "$temp_file"
        fi
    fi
}

# Function to download all files
download_all() {
    echo "Downloading entire directory as an archive..."
    handle_download "GETALL"
}

# Function to download selected files
download_selected() {
    if [ ${#file_array[@]} -eq 0 ]; then
        echo "Please list files first to see available options."
        return
    fi
    echo "Enter space-separated numbers of files to download (e.g., 1 3):"
    read -r numbers
    if [ -z "$numbers" ]; then
        echo "No numbers provided."
        return
    fi
    local selected_files=()
    for num in $numbers; do
        if [[ "$num" =~ ^[0-9]+$ ]] && [ "$num" -ge 1 ] && [ "$num" -le "${#file_array[@]}" ]; then
            local line="${file_array[$num-1]}"
            local filename=$(echo "$line" | sed 's/^ *[0-9]\+\. //')
            selected_files+=("$filename")
        else
            echo "Invalid number: $num (must be between 1 and ${#file_array[@]})"
        fi
    done
    if [ ${#selected_files[@]} -gt 0 ]; then
        local cmd="GET ${selected_files[*]}"
        echo "Downloading selected files as an archive..."
        handle_download "$cmd"
    else
        echo "No valid files selected."
    fi
}

# Main interface loop
while true; do
    echo -e "\nMenu:"
    echo "1. List files"
    echo "2. Download all files"
    echo "3. Download selected files"
    echo "4. Quit"
    read -p "Choose an option (1-4): " choice
    echo
    case "$choice" in
        1) list_files ;;
        2) download_all ;;
        3) download_selected ;;
        4) echo "Exiting..."; exit 0 ;;
        *) echo "Invalid choice, please select 1-4." ;;
    esac
done
