Explanation of the Client Script

Overview

This client script interacts with a server that listens on a specified address and port (defaulting to localhost and 12345). The server supports three commands:

	•	LIST: Returns a numbered list of files in the server’s directory (e.g., “ 1. file1”, “ 2. file2”).
	•	GETALL: Sends the entire directory as a tar.gz archive.
	•	GET : Sends specified files as a tar.gz archive.

The client provides a menu-driven interface with four options: list files, download all files, download selected files, and quit. It uses netcat (nc) to communicate with the server and handles both text responses (for LIST) and binary responses (for GETALL and GET).

Key Components

	1.	Connection Setup
	•	Server and Port: The script accepts command-line arguments for the server address and port (SERVER=${1:-localhost} and PORT=${2:-12345}). If not provided, it defaults to localhost and port 12345.
	•	send_command Function: This function sends a command to the server using nc. It takes a command string as an argument and pipes it to nc for transmission.

send_command() {
    local cmd="$1"
    echo "$cmd" | nc "$SERVER" "$PORT"
}

	2.	Listing Files
	•	list_files Function: Sends the LIST command, captures the output, displays it, and stores it in an array (file_array) for later use. The output is expected to be text, with each line formatted as “ . ”.
	•	Storage: The mapfile -t file_array <<< "$output" command splits the output into array elements, one per line, preserving the numbering for user selection.

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

	3.	Handling Downloads
	•	handle_download Function: A reusable function for both GETALL and GET <filenames>. It:
	•	Sends the command and saves the response to a temporary file.
	•	Checks if the response starts with “Error:” or “Invalid” (indicating a server error).
	•	If it’s an error, displays the message and deletes the temp file.
	•	If it’s a tar.gz archive, prompts the user for a filename and moves the temp file to that location.

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

	4.	Downloading All Files
	•	download_all Function: Simply calls handle_download with the GETALL command to download the entire directory as an archive.

download_all() {
    echo "Downloading entire directory as an archive..."
    handle_download "GETALL"
}

	5.	Downloading Selected Files
	•	download_selected Function: Allows the user to download specific files by number:
	•	Checks if file_array is populated (i.e., LIST has been run).
	•	Prompts for space-separated numbers (e.g., “1 3”).
	•	Validates each number (must be numeric and within range).
	•	Extracts filenames from file_array using sed to remove the “ . “ prefix.
	•	Constructs a GET command with the selected filenames and passes it to handle_download.

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

	6.	Main Interface
	•	A while loop presents a menu with four options:
	•	1: List files.
	•	2: Download all files.
	•	3: Download selected files.
	•	4: Quit.
	•	Uses a case statement to call the appropriate function based on user input.

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


Differences from the Provided Script

The provided script includes features like range selection (e.g., “1-5”) and automatic extraction of tar archives. This client:

	•	Saves Archives: Instead of extracting archives on the fly (tar -xzvf -), it saves them as tar.gz files, giving the user control over extraction.
	•	Simplified Selection: Uses space-separated numbers (e.g., “1 3”) instead of ranges, keeping the logic simpler and more robust for basic use.
	•	Error Handling: Explicitly checks for server error messages and handles them separately from binary data.
	•	File List Caching: Stores the file list in file_array to avoid repeated LIST commands, unlike the provided script which fetches the list anew for each download.

Usage

	1.	Save the script as client.sh.
	2.	Make it executable: chmod +x client.sh.
	3.	Run it: ./client.sh [server_address] [port].
	•	Defaults to localhost and 12345 if no arguments are provided.
	4.	Follow the menu prompts to list files, download all files, or download selected files.

Limitations

	•	Filenames with Spaces: The server splits the GET command on spaces, so filenames with spaces may not work correctly. This is a server-side limitation that the client cannot fully address without server modifications.
	•	Connection Issues: Assumes the server is running and accessible; nc errors (e.g., connection refused) will be displayed but not explicitly handled.
	•	No Range Support: Unlike the provided script, it doesn’t support ranges (e.g., “1-5”), but this could be added by extending download_selected.

This client provides a robust, user-friendly way to interact with the server, balancing functionality with simplicity while meeting the core requirements of listing and downloading files
