#!/bin/bash

# Check if server and port are provided as arguments
if [ $# -ne 2 ]; then
    echo "Usage: $0 <server> <port>"
    echo "Example: $0 localhost 12345"
    exit 1
fi

server=$1
port=$2

while true; do
    echo "Enter command (LIST, GETALL, GET <filenames>, QUIT):"
    read -r cmd

    # Exit the loop if the user enters QUIT
    if [ "$cmd" = "QUIT" ]; then
        echo "Exiting client."
        break
    # Handle LIST command: display the list of files
    elif [ "$cmd" = "LIST" ]; then
        echo "LIST" | nc "$server" "$port"
    # Handle GETALL command: retrieve all files as a tar.gz archive
    elif [ "$cmd" = "GETALL" ]; then
        # Create a temporary file to store the server response
        temp_file=$(mktemp)
        echo "GETALL" | nc "$server" "$port" > "$temp_file"
        # Check if the response is an error message
        if head -n1 "$temp_file" | grep -qE "^(Invalid|Error)"; then
            cat "$temp_file"
            rm "$temp_file"
        else
            # Prompt user for output filename and save the archive
            echo "Enter output filename for all files (e.g., all_files.tar.gz):"
            read -r output_file
            mv "$temp_file" "$output_file"
            echo "Archive saved to $output_file"
        fi
    # Handle GET command with filenames: retrieve specified files as a tar.gz archive
    elif [[ "$cmd" =~ ^GET\ .+ ]]; then
        # Create a temporary file to store the server response
        temp_file=$(mktemp)
        echo "$cmd" | nc "$server" "$port" > "$temp_file"
        # Check if the response is an error message
        if head -n1 "$temp_file" | grep -qE "^(Invalid|Error)"; then
            cat "$temp_file"
            rm "$temp_file"
        else
            # Prompt user for output filename and save the archive
            echo "Enter output filename for selected files (e.g., selected_files.tar.gz):"
            read -r output_file
            mv "$temp_file" "$output_file"
            echo "Archive saved to $output_file"
        fi
    else
        echo "Invalid command. Please enter LIST, GETALL, GET <filenames>, or QUIT."
    fi
done
