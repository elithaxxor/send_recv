#!/usr/bin/env bash

# This script clones specific GitHub repositories that may be Python-based or have their own install script.
# If a repository has a Python requirements.txt, the script creates a virtual environment and installs it.
# If a repository contains an install.sh file, we run that script.
# Repositories are cloned into a user-defined output_dir (defaults to "cloned_repos" if not provided).

# Safety checks
set -e

# Helper Function for error handling
error_exit() {
    echo "[ERROR]: $1" 1>&2
    exit 1
}

# Helper function to detect if repository likely is Python-based
# We consider it Python-based if it has a requirements.txt or a setup.py in the root.
is_python_repo() {
    local repo_path="$1"
    if [[ -f "$repo_path/requirements.txt" || -f "$repo_path/setup.py" ]]; then
        return 0  # True
    else
        return 1  # False
    fi
}

# Helper function to see if there's an install script
has_install_script() {
    local repo_path="$1"
    if [[ -f "$repo_path/install.sh" || -f "$repo_path/setup.sh" ]]; then
        return 0  # True
    else
        return 1  # False
    fi
}

# Main install function
install_ddos_tools() {

    # List of GitHub repositories to clone
    local repos=(
        "https://github.com/Ha3MrX/DDos-Attack.git"
        "https://github.com/anti-ddos/Anti-DDOS.git"
        "https://gith#!/bin/bash

# Helper Function to display installed tools
whatdoido() {
    cat <<EOF
[!] The install_security_
# Array of GitHub repository URLs
repos=(
    "https://github.com/Ha3MrX/DDos-Attack.git"
    "https://github.com/anti-ddos/Anti-DDOS.git"
    "https://github.com/HyukIsBack/KARMA-DDoS.git"
    "https://github.com/Tmpertor/Raven-Storm.git"
    "https://github.com/4lbH4cker/ALHacking.git"
    "https://github.com/Ha3MrX/Hacking.git"
    "https://github.com/D4Vinci/PyFlooder.git"
    "https://github.com/r3nt0n/torDDoS.git"
    "https://github.com/PraneethKarnena/DDoS-Scripts.git"
    "https://github.com/pembriahmad/DDOS.git"
    "https://github.com/HardyTomas/DDos-Attack-OVH-.git"
    "https://github.com/saurass/Zombie-DDoS.git"
    "https://github.com/Err0r-ICA/VARIOUS.git"
    "https://github.com/DarkSkull777/DarkCool.git"
    "https://github.com/mishakorzik/AllHackingTools.git"
    "https://github.com/sammwyy/MikuMikuBeam.git"
    "https://github.com/palahsu/DDoS-Ripper.git"
)

# Create a directory for the cloned repositories
output_dir="cloned_repos"
mkdir -p "$output_dir"

# Clone and guide the user through the process
echo "[INFO]: Starting the cloning process."
for repo in "${repos[@]}"; do
    repo_name=$(basename "$repo" .git)
    echo "[INFO]: Cloning $repo into $output_dir/$repo_name..."
    git clone "$repo" "$output_dir/$repo_name" || error_exit "Failed to clone $repo."
    echo "[INFO]: Successfully cloned $repo_name."
    
    # Check if there's an install script
    if [[ -f "$output_dir/$repo_name/setup.sh" || -f "$output_dir/$repo_name/install.sh" ]]; then
        echo "[INFO]: Found an installation script in $repo_name. Running it now."
        bash "$output_dir/$repo_name/"*install*.sh || echo "[WARNING]: Could not run the installation script for $repo_name."
    else
        echo "[INFO]: No installation script found for $repo_name. You may need to install dependencies manually."
    fi
done

echo "[INFO]: All repositories have been cloned to the $output_dir directory."
echo "[INFO]: Please ensure to review and understand the purpose of each repository before running or installing its contents."

# Display final guidance for responsible use
cat <<EOF

[NOTICE]: This script has cloned several repositories that may include tools for security testing, ethical hacking, or system analysis. 
           1. **Always use such tools responsibly and legally.** Unauthorized use may violate local or international laws.
           2. Review each repository's README.md file for proper usage instructions.
           3. Make sure to run these tools only in environments you own or have explicit permission to test.

EOFand_network_tools function installs the following tools, organized by their utilization:
[1] Network Administration Tools: net-tools, tcpdump, traceroute, mtr, iperf3, dnsutils, whois, tshark, arp-scan, ettercap-common, dsniff
[2] Penetration Testing Tools: metasploit-framework, wireshark, nmap, aircrack-ng, john, hashcat, zaproxy, sqlmap, hydra, proxychains, gobuster, dirb, checksec, nikto, wpscan
[3] Red Teaming & Post-Exploitation Tools: responder, bloodhound, impacket-scripts, crackmapexec, seclists, nishang, powersploit, enum4linux, recon-ng
[4] Web Application & Network Forensics Tools: RouterSploit, Xplico, Apache2, Burp Suite, Maltego, Social Engineering Toolkit (SET), BeEF, zaproxy
[5] Vulnerability Scanners & Security Tools: OpenVAS, SpiderFoot, Tor, Ngrok, libglib2.0-dev, bluepy
[6] Network Utility Tools: Netcat
[7] Python Tools: pipx
[+] All tools have been installed successfully. You can now use them for network administration, penetration testing, vulnerability scanning, OSINT, and more.
EOF
}

# Function to update the OS, apt, and install Python/Java
update_os_and_fetch_versions() {
    echo "[+] Updating the OS and package repositories..."
    sudo apt update -y && sudo apt upgrade -y && sudo apt dist-upgrade -y && sudo apt autoremove -y && sudo apt clean
    echo "[+] Installing Python..."
    sudo apt install -y python3 python3-pip python3-dev && python3 -m pip install --upgrade pip
    echo "[+] Installing Java..."
    sudo apt install -y openjdk-17-jdk && sudo update-alternatives --config java
    java -version
    echo "[+] System updated with the latest Python and Java versions."
}


DDOS_Tools() {

# Array of GitHub repository URLs
repos=(
    "https://github.com/Ha3MrX/DDos-Attack.git"
    "https://github.com/anti-ddos/Anti-DDOS.git"
    "https://github.com/HyukIsBack/KARMA-DDoS.git"
    "https://github.com/Tmpertor/Raven-Storm.git"
    "https://github.com/4lbH4cker/ALHacking.git"
    "https://github.com/Ha3MrX/Hacking.git"
    "https://github.com/D4Vinci/PyFlooder.git"
    "https://github.com/r3nt0n/torDDoS.git"
    "https://github.com/PraneethKarnena/DDoS-Scripts.git"
    "https://github.com/pembriahmad/DDOS.git"
    "https://github.com/HardyTomas/DDos-Attack-OVH-.git"
    "https://github.com/saurass/Zombie-DDoS.git"
    "https://github.com/Err0r-ICA/VARIOUS.git"
    "https://github.com/DarkSkull777/DarkCool.git"
    "https://github.com/mishakorzik/AllHackingTools.git"
    "https://github.com/sammwyy/MikuMikuBeam.git"
    "https://github.com/palahsu/DDoS-Ripper.git"
)

# Create a directory for the cloned repositories
output_dir="cloned_repos"
mkdir -p "$output_dir"

# Clone and guide the user through the process
echo "[INFO]: Starting the cloning process."
for repo in "${repos[@]}"; do
    repo_name=$(basename "$repo" .git)
    echo "[INFO]: Cloning $repo into $output_dir/$repo_name..."
    git clone "$repo" "$output_dir/$repo_name" || error_exit "Failed to clone $repo."
    echo "[INFO]: Successfully cloned $repo_name."
    
    # Check if there's an install script
    if [[ -f "$output_dir/$repo_name/setup.sh" || -f "$output_dir/$repo_name/install.sh" ]]; then
        echo "[INFO]: Found an installation script in $repo_name. Running it now."
        bash "$output_dir/$repo_name/"*install*.sh || echo "[WARNING]: Could not run the installation script for $repo_name."
    else
        echo "[INFO]: No installation script found for $repo_name. You may need to install dependencies manually."
    fi
done

echo "[INFO]: All repositories have been cloned to the $output_dir directory."
echo "[INFO]: Please ensure to review and understand the purpose of each repository before running or installing its contents."

# Display final guidance for responsible use
cat <<EOF

[NOTICE]: This script has cloned several repositories that may include tools for security testing, ethical hacking, or system analysis. 
           1. **Always use such tools responsibly and legally.** Unauthorized use may violate local or international laws.
           2. Review each repository's README.md file for proper usage instructions.
           3. Make sure to run these tools only in environments you own or have explicit permission to test.

EOF

}
OSINTII_TOOLS() {
    repos=(
      "https://github.com/techgaun/github-dorks.git"
      "https://github.com/soxoj/maigret.git"
      "https://github.com/megadose/holehe.git"
      "https://github.com/p1ngul1n0/blackbird.git"
      "https://github.com/0xfff0800/Brute-force-Instagram-2025"
      "https://github.com/Datalux/Osintgram.git"
      "https://github.com/megadose/nqntnqnqmb.git"
    )
    
    # Log file for tracking the process
    LOG_FILE="clone_install.log"gmail
    > "$LOG_FILE"
    
    # Function to clone and install a repository
    clone_and_install() {
      local repo_url=$1gmail
      local repo_name=$(basename "$repo_url" .git)
    
      echo "Processing: $repo_name" | tee -a "$LOG_FILE"
    
      # Clone the repository
      if git clone "$repo_url" "$repo_name"; then
        echo "Cloned $repo_name successfully." | tee -a "$LOG_FILE"
        cd "$repo_name" || exit
    
        # Install dependencies if possible
        if [ -f "requirements.txt" ]; then
          echo "Installing dependencies from requirements.txt..." | tee -a "../$LOG_FILE"
          if ! pip install -r requirements.txt; then
            echo "Failed to install dependencies for $repo_name." | tee -a "../$LOG_FILE"
          fi
        elif [ -f "setup.py" ]; then
          echo "Installing via setup.py..." | tee -a "../$LOG_FILE"
          if ! python setup.py install; then
            echo "Failed to install $repo_name via setup.py." | tee -a "../$LOG_FILE"
          fi
        else
          echo "No installation file found for $repo_name." | tee -a "../$LOG_FILE"
        fi
    
        # Go back to the parent directory
        cd ..
      else
        echo "Failed to clone $repo_name." | tee -a "$LOG_FILE"
      fi
    
      echo "----------------------------------------" | tee -a "$LOG_FILE"
    }
    
    # Iterate over each repository
    for repo in "${repos[@]}"; do
      clone_and_install "$repo"
    done
    
    echo "All repositories processed. Check $LOG_FILE for details."

}
gmail


# Function to clone and install the specified #!/usr/bin/env bash

# This script clones specific GitHub repositories that may be Python-based or have their own install script.
# If a repository has a Python requirements.txt, the script creates a virtual environment and installs it.
# If a repository contains an install.sh file, we run that script.
# Repositories are cloned into a user-defined output_dir (defaults to "cloned_repos" if not provided).

# Safety checks
set -e

# Helper Function for error handling
error_exit() {
    echo "[ERROR]: $1" 1>&2
    exit 1
}

# Helper function to detect if repository likely is Python-based
# We consider it Python-based if it has a requirements.txt or a setup.py in the root.
is_python_repo() {
    local repo_path="$1"
    if [[ -f "$repo_path/requirements.txt" || -f "$repo_path/setup.py" ]]; then
        return 0  # True
    else
        return 1  # False
    fi
}

# Helper function to see if there's an install script
has_install_script() {
    local repo_path="$1"
    if [[ -f "$repo_path/install.sh" || -f "$repo_path/setup.sh" ]]; then
        return 0  # True
    else
        return 1  # False
    fi
}

# Main install function
install_ddos_tools() {

    # List of GitHub repositories to clone
    local repos=(
        "https://github.com/Ha3MrX/DDos-Attack.git"
        "https://github.com/anti-ddos/Anti-DDOS.git"
        "https://gith#!/bin/bash
)
# Helper Function to display installed tools
whatdoido() {
    cat <<EOF
[!] The install_security_
# Array of GitHub repository URLs
repos=(
    "https://github.com/Ha3MrX/DDos-Attack.git"
    "https://github.com/anti-ddos/Anti-DDOS.git"
    "https://github.com/HyukIsBack/KARMA-DDoS.git"
    "https://github.com/Tmpertor/Raven-Storm.git"
    "https://github.com/4lbH4cker/ALHacking.git"
    "https://github.com/Ha3MrX/Hacking.git"
    "https://github.com/D4Vinci/PyFlooder.git"
    "https://github.com/r3nt0n/torDDoS.git"
    "https://github.com/PraneethKarnena/DDoS-Scripts.git"
    "https://github.com/pembriahmad/DDOS.git"
    "https://github.com/HardyTomas/DDos-Attack-OVH-.git"
    "https://github.com/saurass/Zombie-DDoS.git"
    "https://github.com/Err0r-ICA/VARIOUS.git"
    "https://github.com/DarkSkull777/DarkCool.git"
    "https://github.com/mishakorzik/AllHackingTools.git"
    "https://github.com/sammwyy/MikuMikuBeam.git"
    "https://github.com/palahsu/DDoS-Ripper.git"
)

# Create a directory for the cloned repo#!/usr/bin/env bash
gmail
# This script clones specific GitHub repositories that may be Python-based or have their own install script.
# If a repository has a Python requirements.txt, the script creates a virtual environment and installs it.
# If a repository contains an install.sh file, we run that script.
# Repositories are cloned into a user-defined output_dir (defaults to "cloned_repos" if not provided).

# Safety checks
set -e

# Helper Function for error handling
error_exit() {
    echo "[ERROR]: $1" 1>&2
    exit 1
}

# Helper function to detect if repository likely is Python-based
# We consider it Python-based if it has a requirements.txt or a setup.py in the root.
is_python_repo() {
    local repo_path="$1"
    if [[ -f "$repo_path/requirements.txt" || -f "$repo_path/setup.py" ]]; then
        return 0  # True
    else
        return 1  # False
    fi
}

# Helper function to see if there's an install scriptprocessed_redteam
has_install_script() {
    local repo_path="$1"
    if [[ -f "$repo_path/install.sh" || -f "$repo_path/setup.sh" ]]; then
        return 0  # True
    else
        return 1  # False
    fi
}

# Main install function
install_ddos_tools() {

    # List of GitHub repositories to clone
    local repos=(
        "https://github.com/Ha3MrX/DDos-Attack.git"
        "https://github.com/anti-ddos/Anti-DDOS.git"
        "https://gith#!/bin/bash

# Helper Function to display installed tools
whatdoido() {
    cat <<EOF
[!] The install_security_
# Array of GitHub repository URLs
repos=(
    "https://github.com/Ha3MrX/DDos-Attack.git"
    "https://github.com/anti-ddos/Anti-DDOS.git"
    "https://github.com/HyukIsBack/KARMA-DDoS.git"
    "https://github.com/Tmpertor/Raven-Storm.git"
    "https://github.com/4lbH4cker/ALHacking.git"
    "https://github.com/Ha3MrX/Hacking.git"
    "https://github.com/D4Vinci/PyFlooder.git"
    "https://github.com/r3nt0n/torDDoS.git"
    "https://github.com/PraneethKarnena/DDoS-Scripts.git"
    "https://github.com/pembriahmad/DDOS.git"
    "https://github.com/HardyTomas/DDos-Attack-OVH-.git"
    "https://github.com/saurass/Zombie-DDoS.git"
    "https://github.com/Err0r-ICA/VARIOUS.git"
    "https://github.com/DarkSkull777/DarkCool.git"
    "https://github.com/mishakorzik/AllHackingTools.git"
    "https://github.com/sammwyy/MikuMikuBeam.git"gmail
    "https://github.com/palahsu/DDoS-Ripper.git"
)

# Create a directory for the cloned repositories
output_dir="cloned_repos"
mkdir -p "$output_dir"

# Clone and guide the user through the process
echo "[INFO]: Starting the cloning process."
for repo in "${repos[@]}"; do
    repo_name=$(basename "$repo" .git)
    echo "[INFO]: Cloning $repo into $output_dir/$repo_name..."
    git clone "$repo" "$output_dir/$repo_name" || error_exit "Failed to clone $repo."
    echo "[INFO]: Successfully cloned $repo_name."
    
    # Check if there's an install script
    if [[ -f "$output_dir/$repo_name/setup.sh" || -f "$output_dir/$repo_name/install.sh" ]]; then
        echo "[INFO]: Found an installation script in $repo_name. Running it now."
        bash "$output_dir/$repo_name/"*install*.sh || echo "[WARNING]: Could not run the installation script for $repo_name."
    else
        echo "[INFO]: No installation script found for $repo_name. You may need to install dependencies manually."
    fi
done

echo "[INFO]: All repositories have been cloned to the $output_dir directory."
echo "[INFO]: Please ensure to review and understand the purpose of each repository before running or installing its contents."

# Display final guidance for responsible use
cat <<EOF

[NOTICE]: This script has cloned several repositories that may include tools for security testing, ethical hacking, or system analysis. 
           1. **Always use such tools responsibly and legally.** Unauthorized use may violate local or international laws.
           2. Review each repository's README.md file for proper usage instructions.
           3. Make sure to run these tools only in environments you own or have explicit permission to test.

EOFand_network_tools function installs the following tools, organized by their utilization:
[1] Network Administration Tools: net-tools, tcpdump, traceroute, mtr, iperf3, dnsutils, whois, tshark, arp-scan, ettercap-common, dsniff
[2] Penetration Testing Tools: metasploit-framework, wireshark, nmap, aircrack-ng, john, hashcat, zaproxy, sqlmap, hydra, proxychains, gobuster, dirb, checksec, nikto, wpscan
[3] Red Teaming & Post-Exploitation Tools: responder, bloodhound, impacket-scripts, crackmapexec, seclists, nishang, powersploit, enum4linux, recon-ng
[4] Web Application & Network Forensics Tools: RouterSploit, Xplico, Apache2, Burp Suite, Maltego, Social Engineering Toolkit (SET), BeEF, zaproxy
[5] Vulnerability Scanners & Security Tools: OpenVAS, SpiderFoot, Tor, Ngrok, libglib2.0-dev, bluepy
[6] Network Utility Tools: Netcat
[7] Python Tools: pipx
[+] All tools have been installed successfully. You can now use them for network administration, penetration testing, vulnerability scanning, OSINT, and more.
EOF

# Function to update the OS, apt, and install Python/Java
update_os_and_fetch_versions() {
    echo "[+] Updating the OS and package repositories..."
    sudo apt update -y && sudo apt upgrade -y && sudo apt dist-upgrade -y && sudo apt autoremove -y && sudo apt clean
    echo "[+] Installing Python..."
    sudo apt install -y python3 python3-pip python3-dev && python3 -m pip install --upgrade pip
    echo "[+] Installing Java..."
    sudo apt install -y openjdk-17-jdk && sudo update-alternatives --config java
    java -version
    echo "[+] System updated with the latest Python and Java versions."
}


DDOS_Tools() {

# Array of GitHub repository URLs
repos=(
    "https://github.com/Ha3MrX/DDos-Attack.git"
    "https://github.com/anti-ddos/Anti-DDOS.git"
    "https://github.com/HyukIsBack/KARMA-DDoS.git"
    "https://github.com/Tmpertor/Raven-Storm.git"
    "https://github.com/4lbH4cker/ALHacking.git"
    "https://github.com/Ha3MrX/Hacking.git"
    "https://github.com/D4Vinci/PyFlooder.git"
    "https://github.com/r3nt0n/torDDoS.git"
    "https://github.com/PraneethKarnena/DDoS-Scripts.git"
    "https://github.com/pembriahmad/DDOS.git"
    "https://github.com/HardyTomas/DDos-Attack-OVH-.git"
    "https://github.com/saurass/Zombie-DDoS.git"
    "https://github.com/Err0r-ICA/VARIOUS.git"
    "https://github.com/DarkSkull777/DarkCool.git"
    "https://github.com/mishakorzik/AllHackingTools.git"
    "https://github.com/sammwyy/MikuMikuBeam.git"
    "https://github.com/palahsu/DDoS-Ripper.git"
)

# Create a directory for the cloned repositories
output_dir="cloned_repos"
mkdir -p "$output_dir"

# Clone and guide the user through the process
echo "[INFO]: Starting the cloning process."
for repo in "${repos[@]}"; do
    repo_name=$(basename "$repo" .git)
    echo "[INFO]: Cloning $repo into $output_dir/$repo_name..."
    git clone "$repo" "$output_dir/$repo_name" || error_exit "Failed to clone $repo."
    echo "[INFO]: Successfully cloned $repo_name."
    
    # Check if there's an install script
    if [[ -f "$output_dir/$repo_name/setup.sh" || -f "$output_dir/$repo_name/install.sh" ]]; then
        echo "[INFO]: Found an installation script in $repo_name. Running it now."
        bash "$output_dir/$repo_name/"*install*.sh || echo "[WARNING]: Could not run the installation script for $repo_name."
    else
        echo "[INFO]: No installation script found for $repo_name. You may need to install dependencies manually."
    fi
done

echo "[INFO]: All repositories have been cloned to the $output_dir directory."
echo "[INFO]: Please ensure to review and understand the purpose of each repository before running or installing its contents."

# Display final guidance for responsible use
cat <<EOF

[NOTICE]: This script has cloned several repositories that may include tools for security testing, ethical hacking, or system analysis. 
           1. **Always use such tools responsibly and legally.** Unauthorized use may violate local or international laws.
           2. Review each repository's README.md file for proper usage instructions.
           3. Make sure to run these tools only in environments you own or have explicit permission to test.

EOF

}
OSINTII_TOOLS() {
    repos=(
      "https://github.com/techgaun/github-dorks.git"
      "https://github.com/soxoj/maigret.git"
      "https://github.com/megadose/holehe.git"
      "https://github.com/p1ngul1n0/blackbird.git"
      "https://github.com/0xfff0800/Brute-force-Instagram-2025"
      "https://github.com/Datalux/Osintgram.git"
      "https://github.com/megadose/nqntnqnqmb.git"
    )
    
    # Log file for tracking the process
    LOG_FILE="clone_install.log"
    > "$LOG_FILE"
    
    # Function to clone and install a repository
    clone_and_install() {
      local repo_url=$1
      local repo_name=$(basename "$repo_url" .git)
    
      echo "Processing: $repo_name" | tee -a "$LOG_FILE"
    
      # Clone the repository
      if git clone "$repo_url" "$repo_name"; then
        echo "Cloned $repo_name successfully." | tee -a "$LOG_FILE"
        cd "$repo_name" || exit
    
        # Install dependencies if possible
        if [ -f "requirements.txt" ]; then
          echo "Installing dependencies from requirements.txt..." | tee -a "../$LOG_FILE"
          if ! pip install -r requirements.txt; then
            echo "Failed to install dependencies for $repo_name." | tee -a "../$LOG_FILE"
          fi
        elif [ -f "setup.py" ]; then
          echo "Installing via setup.py..." | tee -a "../$LOG_FILE"
          if ! python setup.py install; then
            echo "Failed to install $repo_name via setup.py." | tee -a "../$LOG_FILE"
          fi
        else
          echo "No installation file found for $repo_name." | tee -a "../$LOG_FILE"
        fi
    
        # Go back to the parent directory
        cd ..
      else
        echo "Failed to clone $repo_name." | tee -a "$LOG_FILE"
      fi
    
      echo "----------------------------------------" | tee -a "$LOG_FILE"
    }
    
    # Iterate over each repository
    for repo in "${repos[@]}"; do
      clone_and_install "$repo"
    done
    
    echo "All repositories processed. Check $LOG_FILE for details."

}



# Function to clone and install the specified applications
install_dork_tools() {
  echo "Starting installation of dork tools..."

  # Define repositories in an associative array
  declare -A repositories=(
    ["Fast-Google-Dorks-Scan"]="https://github.com/IvanGlinkin/Fast-Google-Dorks-Scan"
    ["PyDork"]="https://github.com/blacknon/pydork"
    ["0xDork"]="https://github.com/rlyonheart/0xdork"
    ["SDorker"]="https://github.com/TheSpeedX/SDorker"
    ["ASHOK"]="https://github.com/ankitdobhal/Ashok"
    ["Pagodo"]="https://github.com/opsdisk/pagodo"
    ["Katana"]="https://github.com/TebbaaX/Katana"
    ["GO-Dork"]="https://github.com/dwisiswant0/go-dork"
    ["Snitch"]="https://github.com/Smaash/snitch"
    ["Dorks-Eye"]="https://github.com/BullsEye0/dorks-eye"
    ["SQLI-Dorks-Generator"]="https://github.com/Zold1/sqli-dorkprocessed_redteams-generator"
    ["DSH"]="https://github.com/falkensmz/dsh"
    ["Dork-Hunter"]="https://github.com/six2dez/dorks_hunter"
  )

  # Iterate through repositories and process each
  for tool in "${!repositories[@]}"; do
    echo "Cloning $tool from ${repositories[$tool]}..."
    git clone "${repositories[$tool]}"

    # Move into the cloned directory and install if necessary
    dir_name=$(basename "${repositories[$tool]}" .git)
    if [ -d "$dir_name" ]; then
      cd "$dir_name"

      # Run installation steps if a setup file exists
      if [ -f "requirements.txt" ]; then
        echo "Installing dependencies for $tool..."
        pip install -r requirements.txt
      fi
      if [ -f "setup.py" ]; then
        echo "Running setup.py for $tool..."
        python setup.py install
      fi

      # Return to the parent directory
      cd ..
    else
      echo "Error: Failed to find directory $dir_name after cloning."
    fi
  done

  echo "All toolsOSINTII_TOOLSthub.com/martinvigo/email2phonenumber"]="email2phonenumber"
  

  # Directory to store the cloned tools
  TOOL_DIR="$HOME/osint-tools"

  echo "Creating OSINT tools directory at $TOOL_DIR..."
  mkdir -p "$TOOL_DIR"

  for repo in "${!tools[@]}"; do
    tool_name="${tools[$repo]}"
    tool_path="$TOOL_DIR/$tool_name"

    echo "Cloning $repo..."
    if [ -d "$tool_path" ]; then
      echo "$tool_name is already cloned. Skipping..."
    else
      git clone "$repo" "$tool_path"
    fiprocessed_redteam

    echo "Installing dependencies for $tool_name..."
    if [ -f "$tool_path/requirements.txt" ]; then
      python3 -m pip install -r "$tool_path/requirements.txt"
    fi

    # Add alias to ~/.bashrc
    echo "Adding alias for $tool_name to ~/.bashrc..."
    if ! grep -q "alias $tool_name=" "$HOME/.bashrc"; then
      echo "alias $tool_name='python3 $tool_path/${tool_name}.py'" >> "$HOME/.bashrc"
    else
      echo "Alias for $tool_name already exists in ~/.bashrc. Skipping..."
    fi
	done 
  echo "Reloading ~/.bashrc..."
  source "$HOME/.bashrc"

  echo "All tools installed and configured!"

}

# Install common dependencies and tools
install_security_and_network_tools() {
    echo "[+] Installing essential tools for network administration and security..."
    local tools=(
        net-tools tcpdump traceroute mtr iperf3 dnsutils whois tshark arp-scan ettercap-common dsniff
        metasploit-framework wireshark nmap aircrack-ng john hashcat zaproxy sqlmap hydra proxychains
        gobuster dirb checksec nikto wpscan macchanger responder bloodhound impacket-scripts
        crackmapexec seclists nishang powersploit enum4linux recon-ng tor xplico apache2 openvas
        netcat btsscanner ettercap bettercap nikto eyewitness netsniff-ng 
    )
    sudo apt update -y
    sudo apt install -y "${tools[@]}"
    echo "[+] Core tools installed."
}

#!/usr/bin/env bash
#
# install_github_tools.sh
#
# Clones each specified GitHub repository, sets up a Python virtual environment 
# (if a requirements.txt is present), and creates a dedicated launcher file
# in /usr/local/bin for each tool.

#!/usr/bin/env bash
#
# install_github_tools.sh
#
# Clones each specified GitHub repository, sets up a Python virtual environment 
# (if a requirements.txt is present), and creates a dedicated launcher file 
# in /usr/local/bin for each tool.

install_github_tools() {
    # List of GitHub repositories to clone
    local repos=(
        "https://github.com/airgeddon/airgeddon.git"
        "https://github.com/FortyNorthSecurity/EyeWitness.git"
        "https://github.com/threat9/routersploit.git"
        "https://github.com/smicallef/spiderfoot.git"
        "https://github.com/trustedsec/social-engineer-toolkit.git"
        "https://github.com/beefproject/beef.git"
    )
    
    # Target directory for installing tools
    local tool_dir="$HOME/tools"
    echo "[+] Creating tools directory at $tool_dir..."
    mkdir -p "$tool_dir"
    
    # Move into the tools directory
    cd "$tool_dir" || {
        echo "[-] Failed to cd into $tool_dir."
        return 1
    }

    # For convenience, define the main entry points (or commands) for each tool
    # so we know how to run them. If your usage differs, adjust accordingly.
    declare -A main_commands=(
        ["airgeddon"]="bash airgeddon.sh"
        ["EyeWitness"]="python EyeWitness.py"
        ["routersploit"]="python rsf.py"
        ["spiderfoot"]="python spiderfoot.py"
        ["social-engineer-toolkit"]="python setoolkit"
        ["beef"]="bash beef"
    )

    # Clone and install each repo
    for repo in "${repos[@]}"; do
        local name
        name="$(basename "$repo" .git)"processed_redteam

        echo "============================================="
        echo "[+] Processing: $name"
        echo "============================================="

        # Clone the repository if not present
        if [ ! -d "$name" ]; then
            echo "[+] Cloning $name from $repo..."
            git clone "$repo"
        else
            echo "[!] $name is already cloned. Pulling latest changes..."
            cd "$name" || continue
            git pull
            cd ..
        fi

        # Move into the tool's directory
        cd "$name" || continue

        # Check if there's a requirements.txt for Python-based tools
        if [ -f "requirements.txt" ]; then
            echo "[+] Found requirements.txt for $name."
            echo "[+] Creating and activating a virtual environment..."
            python3 -m venv venv
            # Activate the venv
            source venv/bin/activate
            echo "[+] Installing dependencies in virtual environment..."
            pip install --upgrade pip wheel
            pip install -r requirements.txt
            # Deactivate the venv
            deactivate
            echo "[+] Virtual environment setup complete for $name."
        else
            echo "[-] No requirements.txt found for $name. Skipping Python venv setup."
        fi

        # Go back to $tool_dir to set up a wrapper script
        cd ..

        # Create a wrapper script in /usr/local/bin
        local cmd="${main_commands[$name]}"
        if [ -n "$cmd" ]; then
            echo "[+] Creating launcher script for $name in /usr/local/bin/$name ..."
            
            # Path to the to#!/usr/bin/env bash

# This script clones specific GitHub repositories that may be Python-based or have their own install script.
# If a repository has a Python requirements.txt, the script creates a virtual environment and installs it.
# If a repository contains an install.sh file, we run that script.
# Repositories are cloned into a user-defined output_dir (defaults to "cloned_repos" if not provided).

# Safety checks
set -e

# Helper Function for error handling
error_exit() {
    echo "[ERROR]: $1" 1>&2
    exit 1
}

# Helper function to detect if repository likely is Python-based
# We consider it Python-based if it has a requirements.txt or a setup.py in the root.
is_python_repo() {
    local repo_path="$1"
    if [[ -f "$repo_path/requirements.txt" || -f "$repo_path/setup.py" ]]; then
        return 0  # True
    else
        return 1  # False
    fi
}

# Helper function to see if there's an install script
has_install_script() {
    local repo_path="$1"
    if [[ -f "$repo_path/install.sh" || -f "$repo_path/setup.sh" ]]; then
        return 0  # True
    else
        return 1  # False
    fi
}

# Main install function
install_ddos_tools() {

    # List of GitHub repositories to clone
    local repos=(
        "https://github.com/Ha3MrX/DDos-Attack.git"
        "https://github.com/anti-ddos/Anti-DDOS.git"
        "https://gith#!/bin/bash

# Helper Function to display installed tools
whatdoido() {
    cat <<EOF
[!] The install_security_
# Array of GitHub repository URLs
repos=(
    "https://github.com/Ha3MrX/DDos-Attack.git"
    "https://github.com/anti-ddos/Anti-DDOS.git"
    "https://github.com/HyukIsBack/KARMA-DDoS.git"
    "https://github.com/Tmpertor/Raven-Storm.git"
    "https://github.com/4lbH4cker/ALHacking.git"
    "https://github.com/Ha3MrX/Hacking.git"
    "https://github.com/D4Vinci/PyFlooder.git"
    "https://github.com/r3nt0n/torDDoS.git"
    "https://github.com/PraneethKarnena/DDoS-Scripts.git"
    "https://github.com/pembriahmad/DDOS.git"
    "https://github.com/HardyTomas/DDos-Attack-OVH-.git"
    "https://github.com/saurass/Zombie-DDoS.git"
    "https://github.com/Err0r-ICA/VARIOUS.git"
    "https://github.com/DarkSkull777/DarkCool.git"
    "https://github.com/mishakorzik/AllHackingTools.git"
    "https://github.com/sammwyy/MikuMikuBeam.git"
    "https://github.com/palahsu/DDoS-Ripper.git"
)

# Create a directory for the cloned repositories
output_dir="cloned_repos"
mkdir -p "$output_dir"

# Clone and guide the user through the process
echo "[INFO]: Starting the cloning process."
for repo in "${repos[@]}"; do
    repo_name=$(basename "$repo" .git)
    echo "[INFO]: Cloning $repo into $output_dir/$repo_name..."
    git clone "$repo" "$output_dir/$repo_name" || error_exit "Failed to clone $repo."
    echo "[INFO]: Successfully cloned $repo_name."
    
    # Check if there's an install script
    if [[ -f "$output_dir/$repo_name/setup.sh" || -f "$output_dir/$repo_name/install.sh" ]]; then
        echo "[INFO]: Found an installation script in $repo_name. Running it now."
        bash "$output_dir/$repo_name/"*install*.sh || echo "[WARNING]: Could not run the installation script for $repo_name."
    else
        echo "[INFO]: No installation script found for $repo_name. You may need to install dependencies manually."
    fi
done

echo "[INFO]: All repositories have been cloned to the $output_dir directory."
echo "[INFO]: Please ensure to review and understand the purpose of each repository before running or installing its contents."

# Display final guidance for responsible use
cat <<EOF

[NOTICE]: This script has cloned several repositories that may include tools for security testing, ethical hacking, or system analysis. 
           1. **Always use such tools responsibly and legally.** Unauthorized use may violate local or international laws.
           2. Review each repository's README.md file for proper usage instructions.
           3. Make sure to run these tools only in environments you own or have explicit permission to test.

EOFand_network_tools function installs the following tools, organized by their utilization:
[1] Network Administration Tools: net-tools, tcpdump, traceroute, mtr, iperf3, dnsutils, whois, tshark, arp-scan, ettercap-common, dsniff
[2] Penetration Testing Tools: metasploit-framework, wireshark, nmap, aircrack-ng, john, hashcat, zaproxy, sqlmap, hydra, proxychains, gobuster, dirb, checksec, nikto, wpscan
[3] Red Teaming & Post-Exploitation Tools: responder, bloodhound, impacket-scripts, crackmapexec, seclists, nishang, powersploit, enum4linux, recon-ng
[4] Web Application & Network Forensics Tools: RouterSploit, Xplico, Apache2, Burp Suite, Maltego, Social Engineering Toolkit (SET), BeEF, zaproxy
[5] Vulnerability Scanners & Security Tools: OpenVAS, SpiderFoot, Tor, Ngrok, libglib2.0-dev, bluepy
[6] Network Utility Tools: Netcat
[7] Python Tools: pipx
[+] All tools have been installed successfully. You can now use them for network administration, penetration testing, vulnerability scanning, OSINT, and more.
EOF
}

# Function to update the OS, apt, and install Python/Java
update_os_and_fetch_versions() {
    echo "[+] Updating the OS and package repositories..."
    sudo apt update -y && sudo apt upgrade -y && sudo apt dist-upgrade -y && sudo apt autoremove -y && sudo apt clean
    echo "[+] Installing Python..."
    sudo apt install -y python3 python3-pip python3-dev && python3 -m pip install --upgrade pip
    echo "[+] Installing Java..."
    sudo apt install -y openjdk-17-jdk && sudo update-alternatives --config java
    java -version
    echo "[+] System updated with the latest Python and Java versions."
}


DDOS_Tools() {

# Array of GitHub repository URLs
repos=(
    "https://github.com/Ha3MrX/DDos-Attack.git"
    "https://github.com/anti-ddos/Anti-DDOS.git"
    "https://github.com/HyukIsBack/KARMA-DDoS.git"
    "https://github.com/Tmpertor/Raven-Storm.git"
    "https://github.com/4lbH4cker/ALHacking.git"
    "https://github.com/Ha3MrX/Hacking.git"
    "https://github.com/D4Vinci/PyFlooder.git"
    "https://github.com/r3nt0n/torDDoS.git"
    "https://github.com/PraneethKarnena/DDoS-Scripts.git"
    "https://github.com/pembriahmad/DDOS.git"
    "https://github.com/HardyTomas/DDos-Attack-OVH-.git"
    "https://github.com/saurass/Zombie-DDoS.git"
    "https://github.com/Err0r-ICA/VARIOUS.git"
    "https://github.com/DarkSkull777/DarkCool.git"
    "https://github.com/mishakorzik/AllHackingTools.git"
    "https://github.com/sammwyy/MikuMikuBeam.git"
    "https://github.com/palahsu/DDoS-Ripper.git"
)

# Create a directory for the cloned repositories
output_dir="cloned_repos"
mkdir -p "$output_dir"

# Clone and guide the user through the process
echo "[INFO]: Starting the cloning process."
for repo in "${repos[@]}"; do
    repo_name=$(basename "$repo" .git)
    echo "[INFO]: Cloning $repo into $output_dir/$repo_name..."
    git clone "$repo" "$output_dir/$repo_name" || error_exit "Failed to clone $repo."
    echo "[INFO]: Successfully cloned $repo_name."
    
    # Check if there's an install script
    if [[ -f "$output_dir/$repo_name/setup.sh" || -f "$output_dir/$repo_name/install.sh" ]]; then
        echo "[INFO]: Found an installation script in $repo_name. Running it now."
        bash "$output_dir/$repo_name/"*install*.sh || echo "[WARNING]: Could not run the installation script for $repo_name."
    else
        echo "[INFO]: No installation script found for $repo_name. You may need to install dependencies manually."
    fi
done

echo "[INFO]: All repositories have been cloned to the $output_dir directory."
echo "[INFO]: Please ensure to review and understand the purpose of each repository before running or installing its contents."

# Display final guidance for responsible use
cat <<EOF

[NOTICE]: This script has cloned several repositories that may include tools for security testing, ethical hacking, or system analysis. 
           1. **Always use such tools responsibly and legally.** Unauthorized use may violate local or international laws.
           2. Review each repository's README.md file for proper usage instructions.
           3. Make sure to run these tools only in environments you own or have explicit permission to test.

EOF

}
OSINTII_TOOLS() {
    repos=(
      "https://github.com/techgaun/github-dorks.git"
      "https://github.com/soxoj/maigret.git"
      "https://github.com/megadose/holehe.git"
      "https://github.com/p1ngul1n0/blackbird.git"
      "https://github.com/0xfff0800/Brute-force-Instagram-2025"
      "https://github.com/Datalux/Osintgram.git"
      "https://github.com/megadose/nqntnqnqmb.git"
    )
    
    # Log file for tracking the process
    LOG_FILE="clone_install.log"
    > "$LOG_FILE"
    
    # Function to clone and install a repository
    clone_and_install() {
      local repo_url=$1
      local repo_name=$(basename "$repo_url" .git)
    
      echo "Processing: $repo_name" | tee -a "$LOG_FILE"
    
      # Clone the repository
      if git clone "$repo_url" "$repo_name"; then
        echo "Cloned $repo_name successfully." | tee -a "$LOG_FILE"
        cd "$repo_name" || exit
    
        # Install dependencies if possible
        if [ -f "requirements.txt" ]; then
          echo "Installing dependencies from requirements.txt..." | tee -a "../$LOG_FILE"
          if ! pip install -r requirements.txt; then
            echo "Failed to install dependencies for $repo_name." | tee -a "../$LOG_FILE"
          fi
        elif [ -f "setup.py" ]; then
          echo "Installing via setup.py..." | tee -a "../$LOG_FILE"
          if ! python setup.py install; then
            echo "Failed to install $repo_name via setup.py." | tee -a "../$LOG_FILE"
          fi
        else
          echo "No installation file found for $repo_name." | tee -a "../$LOG_FILE"
        fi
    
        # Go back to the parent directory
        cd ..
      else
        echo "Failed to clone $repo_name." | tee -a "$LOG_FILE"
      fi
    
      echo "----------------------------------------" | tee -a "$LOG_FILE"
    }
    
    # Iterate over each repository
    for repo in "${repos[@]}"; do
      clone_and_install "$repo"
    done
    
    echo "All repositories processed. Check $LOG_FILE for details."

}



# Function to clone and install the specified applications
install_dork_tools() {
  echo "Starting installation of dork tools..."

  # Define repositories in an associative array
  declare -A repositories=(
    ["Fast-Google-Dorks-Scan"]="https://github.com/IvanGlinkin/Fast-Google-Dorks-Scan"
    ["PyDork"]="https://github.com/blacknon/pydork"
    ["0xDork"]="https://github.com/rlyonheart/0xdork"
    ["SDorker"]="https://github.com/TheSpeedX/SDorker"
    ["ASHOK"]="https://github.com/ankitdobhal/Ashok"
    ["Pagodo"]="https://github.com/opsdisk/pagodo"
    ["Katana"]="https://github.com/TebbaaX/Katana"
    ["GO-Dork"]="https://github.com/dwisiswant0/go-dork"
    ["Snitch"]="https://github.com/Smaash/snitch"
    ["Dorks-Eye"]="https://github.com/BullsEye0/dorks-eye"
    ["SQLI-Dorks-Generator"]="https://github.com/Zold1/sqli-dorks-generator"
    ["DSH"]="https://github.com/falkensmz/dsh"
    ["Dork-Hunter"]="https://github.com/six2dez/dorks_hunter"
  )

  # Iterate through repositories and process each
  for tool in "${!repositories[@]}"; do
    echo "Cloning $tool from ${repositories[$tool]}..."
    git clone "${repositories[$tool]}"

    # Move into the cloned directory and install if necessary
    dir_name=$(basename "${repositories[$tool]}" .git)
    if [ -d "$dir_name" ]; then
      cd "$dir_name"

      # Run installation steps if a setup file exists
      if [ -f "requirements.txt" ]; then
        echo "Installing dependencies for $tool..."
        pip install -r requirements.txt
      fi
      if [ -f "setup.py" ]; then
        echo "Running setup.py for $tool..."
        python setup.py install
      fi

      # Return to the parent directory
      cd ..
    else
      echo "Error: Failed to find directory $dir_name after cloning."
    fi
  done

  echo "All toolsOSINTII_TOOLSthub.com/martinvigo/email2phonenumber"]="email2phonenumber"
  

  # Directory to store the cloned tools
  TOOL_DIR="$HOME/osint-tools"

  echo "Creating OSINT tools directory at $TOOL_DIR..."
  mkdir -p "$TOOL_DIR"

  for repo in "${!tools[@]}"; do
    tool_name="${tools[$repo]}"
    tool_path="$TOOL_DIR/$tool_name"

    echo "Cloning $repo..."
    if [ -d "$tool_path" ]; then
      echo "$tool_name is already cloned. Skipping..."
    else
      git clone "$repo" "$tool_path"
    fi

    echo "Installing dependencies for $tool_name..."
    if [ -f "$tool_path/requirements.txt" ]; then
      python3 -m pip install -r "$tool_path/requirements.txt"
    fi

    # Add alias to ~/.bashrc
    echo "Adding alias for $tool_name to ~/.bashrc..."
    if ! grep -q "alias $tool_name=" "$HOME/.bashrc"; then
      echo "alias $tool_name='python3 $tool_path/${tool_name}.py'" >> "$HOME/.bashrc"
    else
      echo "Alias for $tool_name already exists in ~/.bashrc. Skipping..."
    fi
  done

  echo "Reloading ~/.bashrc..."
  source "$HOME/.bashrc"

  echo "All tools installed and configured!"
}

# Install common dependencies and tools
install_security_and_network_tools() {
    echo "[+] Installing essential tools for network administration and security..."
    local tools=(
        net-tools tcpdump traceroute mtr iperf3 dnsutils whois tshark arp-scan ettercap-common dsniff
        metasploit-framework wireshark nmap aircrack-ng john hashcat zaproxy sqlmap hydra proxychains
        gobuster dirb checksec nikto wpscan macchanger responder bloodhound impacket-scripts
        crackmapexec seclists nishang powersploit enum4linux recon-ng tor xplico apache2 openvas
        netcat btsscanner ettercap bettercap nikto eyewitness netsniff-ng 
    )
    sudo apt update -y
    sudo apt install -y "${tools[@]}"
    echo "[+] Core tools installed."
}
#!/usr/bin/env bash
#
# install_github_tools.sh
#
# Clones each specified GitHub repository, sets up a Python virtual environment 
# (if a requirements.txt is present), and creates a dedicated launcher file 
# in /usr/local/bin for each tool.

#!/usr/bin/env bash
#
# install_github_tools.sh
#
# Clones each specified GitHub repository, sets up a Python virtual environment 
# (if a requirements.txt is present), and creates a dedicated launcher file 
# in /usr/local/bin for each tool.

install_github_tools() {
    local repos=(
        "https://github.com/airgeddon/airgeddon.git"
        "https://github.com/FortyNorthSecurity/EyeWitness.git"
        "https://github.com/threat9/routersploit.git"
        "https://github.com/smicallef/spiderfoot.git"
        "https://github.com/trustedsec/social-engineer-toolkit.git"
        "https://github.com/beefproject/beef.git"
    )
    
    # Target directory for installing tools
    local tool_dir="$HOME/tools"
    echo "[+] Creating tools directory at $tool_dir..."
    mkdir -p "$tool_dir"
    
    # Move into the tools directory
    cd "$tool_dir" || {
        echo "[-] Failed to cd into $tool_dir."
        return 1
    }

    # For convenience, define the main entry points (or commands) for each tool
    # so we know how to run them. If your usage differs, adjust accordingly.
    declare -A main_commands=(
        ["airgeddon"]="bash airgeddon.sh"
        ["EyeWitness"]="python EyeWitness.py"
        ["routersploit"]="python rsf.py"
        ["spiderfoot"]="python spiderfoot.py"
        ["social-engineer-toolkit"]="python setoolkit"
        ["beef"]="bash beef"
    )

    # Clone and install each repo
    for repo in "${repos[@]}"; do
        local name
        name="$(basename "$repo" .git)"

        echo "============================================="
        echo "[+] Processing: $name"
        echo "============================================="

        # Clone the repository if not present
        if [ ! -d "$name" ]; then
            echo "[+] Cloning $name from $repo..."
            git clone "$repo"
        else
            echo "[!] $name is already cloned. Pulling latest changes..."
            cd "$name" || continue
            git pull
            cd ..
        fi

        # Move into the tool's directory
        cd "$name" || continue

        # Check if there's a requirements.txt for Python-based tools
        if [ -f "requirements.txt" ]; then
            echo "[+] Found requirements.txt for $name."
            echo "[+] Creating and activating a virtual environment..."
            python3 -m venv venv
            # Activate the venv
            source venv/bin/activate
            echo "[+] Installing dependencies in virtual environment..."
            pip install --upgrade pip wheel
            pip install -r requirements.txt
            # Deactivate the venv
            deactivate
            echo "[+] Virtual environment setup complete for $name."
        else
            echo "[-] No requirements.txt found for $name. Skipping Python venv setup."
        fi

        # Go back to $tool_dir to set up a wrapper script
        cd ..

        # Create a wrapper script in /usr/local/bin
        local cmd="${main_commands[$name]}"
        if [ -n "$cmd" ]; then
            echo "[+] Creating launcher script for $name in /usr/local/bin/$name ..."
            
            # Path to the tool directory
            local tool_path="$tool_dir/$name"
            
            # Create the launcher
            cat <<EOF | sudo tee "/usr/local/bin/$name" >/dev/null
#!/usr/bin/env bash
# Launcher for $name

# If a venv exists, activate it
if [ -f "$tool_path/venv/bin/activate" ]; then
    source "$tool_path/venv/bin/activate"
fi

cd "$tool_path" || exit 1
exec $cmd "\$@"
EOF
            
            # Make the wrapper executable
            sudo chmod +x "/usr/local/bin/$name"
            
            echo "[+] Wrapper script created: /usr/local/bin/$name"
        else
            echo "[-] No main command defined for $name; skipping launcher script."
        fi
        
    done

    echo "[+] All repositories have been processed. Installations and wrapper scripts complete."
}


# Final installation wrapper
install_tools() {
    echo "[+] Starting tool installation..."
    update_os_and_fetch_versions
    install_security_and_network_tools
    install_github_tools
    OSINTII_TOOLS
    install_dork_tools
    DDOS_Tools 

    echo "[+] All tools have been successfully installed. Happy hacking!"
}

# Add commands to your shell profile for ease of use
alias install_tools="install_tools"
alias whatdoido="whatdoido"

# Ensure ~/.bashrc changes are loaded
echo "[+] Aliases added. Run 'source ~/.bashrc' or restart your terminal to apply changes."ub.com/HyukIsBack/KARMA-DDoS.git"
        "https://github.com/Tmpertor/Raven-Storm.git"
        "https://github.com/4lbH4cker/ALHacking.git"
        "https://github.com/Ha3MrX/Hacking.git"
        "https://github.com/D4Vinci/PyFlooder.git"
        "https://github.com/r3nt0n/torDDoS.git"
        "https://github.com/PraneethKarnena/DDoS-Scripts.git"
        "https://github.com/pembriahmad/DDOS.git"
        "https://github.com/HardyTomas/DDos-Attack-OVH-.git"
        "https://github.com/saurass/Zombie-DDoS.git"
        "https://github.com/Err0r-ICA/VARIOUS.git"
        "https://github.com/DarkSkull777/DarkCool.git"
        "https://github.com/mishakorzik/AllHackingTools.git"
        "https://github.com/sammwyy/MikuMikuBeam.git"
        "https://github.com/palahsu/DDoS-Ripper.git"
    )

    # Create a directory for the cloned repositories
    local output_dir="${1:-cloned_repos}"  # if 1st argument is not provided, defaults to cloned_repos
    mkdir -p "$output_dir"

    echo "[INFO]: Starting the cloning process."
    for repo in "${repos[@]}"; do
        local repo_name=$(basename "$repo" .git)
        echo "[INFO]: Cloning $repo into $output_dir/$repo_name..."
        if [ ! -d "$output_dir/$repo_name" ]; then
            git clone "$repo" "$output_dir/$repo_name" || error_exit "Failed to clone $repo."
            echo "[INFO]: Successfully cloned $repo_name."
        else
            echo "[INFO]: $repo_name already exists. Pulling latest changes..."
            (cd "$output_dir/$repo_name" && git pull)
        fi

        # Check for install script
        if has_install_script "$output_dir/$repo_name"; then
            echo "[INFO]: Found an installation script in $repo_name. Marking as executable and running it..."
            chmod +x "$output_dir/$repo_name"/*install*.sh
            (cd "$output_dir/$repo_name" && bash ./*install*.sh) || echo "[WARNING]: Could not run the installation script for $repo_name."
        else
            echo "[INFO]: No installation script found for $repo_name."
            # Check if it is python-based, if so create venv and install
            if is_python_repo "$output_dir/$repo_name"; then
                echo "[INFO]: $repo_name appears to be a Python repo. Creating virtual environment and installing."
                cd "$output_dir/$repo_name" || continue
                python3 -m venv venv
                source venv/bin/activate
                if [[ -f "requirements.txt" ]]; then
                    echo "[INFO]: Installing from requirements.txt..."
                    pip install --upgrade pip
                    pip install -r requirements.txt
                elif [[ -f "setup.py" ]]; then
                    echo "[INFO]: Running setup.py install..."
                    pip install --upgrade pip
                    python setup.py install
                fi
                deactivate
                cd -
            else
                echo "[INFO]: $repo_name doesn't appear to be Python-based. Skipping venv setup."
            fi
        fi
    done

    echo "[INFO]: All repositories have been processed."
    echo "[INFO]: Please ensure to review and understand the purpose of each repository before running or installing its contents."
}

# Example usage:
#   ./install.sh [output_directory]
# If no output_directory is provided, it defaults to "cloned_repos".

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    install_ddos_tools "$1"
fiol directory
            local tool_path="$tool_dir/$name"
            
            # Create the launcher
            cat <<EOF | sudo tee "/usr/local/bin/$name" >/dev/null
#!/usr/bin/env bash
# Launcher for $name

# If a venv exists, activate it
if [ -f "$tool_path/venv/bin/activate" ]; then
    source "$tool_path/venv/bin/activate"
fi

cd "$tool_path" || exit 1
exec $cmd "\$@"
EOF
            
            # Make the wrapper executable
            sudo chmod +x "/usr/local/bin/$name"
            
            echo "[+] Wrapper script created: /usr/local/bin/$name"
        else
            echo "[-] No main command defined for $name; skipping launcher script."
        fi
        
    done

    echo "[+] All repositories have been processed. Installations and wrapper scripts complete."
}


# Final installation wrapper
install_tools() {
    echo "[+] Starting tool installation..."
    update_os_and_fetch_versions
    install_security_and_network_tools
    install_github_tools
    OSINTII_TOOLS
    install_dork_tools
    DDOS_Tools 

    echo "[+] All tools have been successfully installed. Happy hacking!"
}

# Add commands to your shell profile for ease of use
alias install_tools="install_tools"
alias whatdoido="whatdoido"

# Ensure ~/.bashrc changes are loaded
echo "[+] Aliases added. Run 'source ~/.bashrc' or restart your terminal to apply changes."ub.com/HyukIsBack/KARMA-DDoS.git"
        "https://github.com/Tmpertor/Raven-Storm.git"
        "https://github.com/4lbH4cker/ALHacking.git"
        "https://github.com/Ha3MrX/Hacking.git"
        "https://github.com/D4Vinci/PyFlooder.git"
        "https://github.com/r3nt0n/torDDoS.git"
        "https://github.com/PraneethKarnena/DDoS-Scripts.git"
        "https://github.com/pembriahmad/DDOS.git"
        "https://github.com/HardyTomas/DDos-Attack-OVH-.git"
        "https://github.com/saurass/Zombie-DDoS.git"
        "https://github.com/Err0r-ICA/VARIOUS.git"
        "https://github.com/DarkSkull777/DarkCool.git"
        "https://github.com/mishakorzik/AllHackingTools.git"
        "https://github.com/sammwyy/MikuMikuBeam.git"
        "https://github.com/palahsu/DDoS-Ripper.git"
    )

    # Create a directory for the cloned repositories
    local output_dir="${1:-cloned_repos}"  # if 1st argument is not provided, defaults to cloned_repos
    mkdir -p "$output_dir"

    echo "[INFO]: Starting the cloning process."
    for repo in "${repos[@]}"; do
        local repo_name=$(basename "$repo" .git)
        echo "[INFO]: Cloning $repo into $output_dir/$repo_name..."
        if [ ! -d "$output_dir/$repo_name" ]; then
            git clone "$repo" "$output_dir/$repo_name" || error_exit "Failed to clone $repo."
            echo "[INFO]: Successfully cloned $repo_name."
        else
            echo "[INFO]: $repo_name already exists. Pulling latest changes..."
            (cd "$output_dir/$repo_name" && git pull)
        fi

        # Check for install script
        if has_install_script "$output_dir/$repo_name"; then
            echo "[INFO]: Found an installation script in $repo_name. Marking as executable and running it..."
            chmod +x "$output_dir/$repo_name"/*install*.sh
            (cd "$output_dir/$repo_name" && bash ./*install*.sh) || echo "[WARNING]: Could not run the installation script for $repo_name."
        else
            echo "[INFO]: No installation script found for $repo_name."
            # Check if it is python-based, if so create venv and install
            if is_python_repo "$output_dir/$repo_name"; then
                echo "[INFO]: $repo_name appears to be a Python repo. Creating virtual environment and installing."
                cd "$output_dir/$repo_name" || continue
                python3 -m venv venv
                source venv/bin/activate
                if [[ -f "requirements.txt" ]]; then
                    echo "[INFO]: Installing from requirements.txt..."
                    pip install --upgrade pip
                    pip install -r requirements.txt
                elif [[ -f "setup.py" ]]; then
                    echo "[INFO]: Running setup.py install..."
                    pip install --upgrade pip
                    python setup.py install
                fi
                deactivate
                cd -
            else
                echo "[INFO]: $repo_name doesn't appear to be Python-based. Skipping venv setup."
            fi
        fi
    done

    echo "[INFO]: All repositories have been processed."
    echo "[INFO]: Please ensure to review and understand the purpose of each repository before running or installing its contents."
}

# Example usage:
#   ./install.sh [output_directory]
# If no output_directory is provided, it defaults to "cloned_repos".

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    install_ddos_tools "$1"
fisitories
output_dir="cloned_repos"
mkdir -p "$output_dir"

# Clone and guide the user through the process
echo "[INFO]: Starting the cloning process."
for repo in "${repos[@]}"; do
    repo_name=$(basename "$repo" .git)
    echo "[INFO]: Cloning $repo into $output_dir/$repo_name..."
    git clone "$repo" "$output_dir/$repo_name" || error_exit "Failed to clone $repo."
    echo "[INFO]: Successfully cloned $repo_name."
    
    # Check if there's an install script
    if [[ -f "$output_dir/$repo_name/setup.sh" || -f "$output_dir/$repo_name/install.sh" ]]; then
        echo "[INFO]: Found an installation script in $repo_name. Running it now."
        bash "$output_dir/$repo_name/"*install*.sh || echo "[WARNING]: Could not run the installation script for $repo_name."
    else
        echo "[INFO]: No installation script found for $repo_name. You may need to install dependencies manually."
    fi
done

echo "[INFO]: All repositories have been cloned to the $output_dir directory."
echo "[INFO]: Please ensure to review and understand the purpose of each repository before running or installing its contents."

# Display final guidance for responsible use
cat <<EOF

[NOTICE]: This script has cloned several repositories that may include tools for security testing, ethical hacking, or system analysis. 
           1. **Always use such tools responsibly and legally.** Unauthorized use may violate local or international laws.
           2. Review each repository's README.md file for proper usage instructions.
           3. Make sure to run these tools only in environments you own or have explicit permission to test.

EOFand_network_tools function installs the following tools, organized by their utilization:
[1] Network Administration Tools: net-tools, tcpdump, traceroute, mtr, iperf3, dnsutils, whois, tshark, arp-scan, ettercap-common, dsniff
[2] Penetration Testing Tools: metasploit-framework, wireshark, nmap, aircrack-ng, john, hashcat, zaproxy, sqlmap, hydra, proxychains, gobuster, dirb, checksec, nikto, wpscan
[3] Red Teaming & Post-Exploitation Tools: responder, bloodhound, impacket-scripts, crackmapexec, seclists, nishang, powersploit, enum4linux, recon-ng
[4] Web Application & Network Forensics Tools: RouterSploit, Xplico, Apache2, Burp Suite, Maltego, Social Engineering Toolkit (SET), BeEF, zaproxy
[5] Vulnerability Scanners & Security Tools: OpenVAS, SpiderFoot, Tor, Ngrok, libglib2.0-dev, bluepy
[6] Network Utility Tools: Netcat
[7] Python Tools: pipx
[+] All tools have been installed successfully. You can now use them for network administration, penetration testing, vulnerability scanning, OSINT, and more.
EOF
}

# Function to update the OS, apt, and install Python/Java
update_os_and_fetch_versions() {
    echo "[+] Updating the OS and package repositories..."
    sudo apt update -y && sudo apt upgrade -y && sudo apt dist-upgrade -y && sudo apt autoremove -y && sudo apt clean
    echo "[+] Installing Python..."
    sudo apt install -y python3 python3-pip python3-dev && python3 -m pip install --upgrade pip
    echo "[+] Installing Java..."
    sudo apt install -y openjdk-17-jdk && sudo update-alternatives --config java
    java -version
    echo "[+] System updated with the latest Python and Java versions."
}


DDOS_Tools() {

# Array of GitHub repository URLs
repos=(
    "https://github.com/Ha3MrX/DDos-Attack.git"
    "https://github.com/anti-ddos/Anti-DDOS.git"
    "https://github.com/HyukIsBack/KARMA-DDoS.git"
    "https://github.com/Tmpertor/Raven-Storm.git"
    "https://github.com/4lbH4cker/ALHacking.git"
    "https://github.com/Ha3MrX/Hacking.git"
    "https://github.com/D4Vinci/PyFlooder.git"
    "https://github.com/r3nt0n/torDDoS.git"
    "https://github.com/PraneethKarnena/DDoS-Scripts.git"
    "https://github.com/pembriahmad/DDOS.git"
    "https://github.com/HardyTomas/DDos-Attack-OVH-.git"
    "https://github.com/saurass/Zombie-DDoS.git"
    "https://github.com/Err0r-ICA/VARIOUS.git"
    "https://github.com/DarkSkull777/DarkCool.git"
    "https://github.com/mishakorzik/AllHackingTools.git"
    "https://github.com/sammwyy/MikuMikuBeam.git"
    "https://github.com/palahsu/DDoS-Ripper.git"
)

# Create a directory for the cloned repositories
output_dir="cloned_repos"
mkdir -p "$output_dir"

# Clone and guide the user through the process
echo "[INFO]: Starting the cloning process."
for repo in "${repos[@]}"; do
    repo_name=$(basename "$repo" .git)
    echo "[INFO]: Cloning $repo into $output_dir/$repo_name..."
    git clone "$repo" "$output_dir/$repo_name" || error_exit "Failed to clone $repo."
    echo "[INFO]: Successfully cloned $repo_name."
    
    # Check if there's an install script
    if [[ -f "$output_dir/$repo_name/setup.sh" || -f "$output_dir/$repo_name/install.sh" ]]; then
        echo "[INFO]: Found an installation script in $repo_name. Running it now."
        bash "$output_dir/$repo_name/"*install*.sh || echo "[WARNING]: Could not run the installation script for $repo_name."
    else
        echo "[INFO]: No installation script found for $repo_name. You may need to install dependencies manually."
    fi
done

echo "[INFO]: All repositories have been cloned to the $output_dir directory."
echo "[INFO]: Please ensure to review and understand the purpose of each repository before running or installing its contents."

# Display final guidance for responsible use
cat <<EOF

[NOTICE]: This script has cloned several repositories that may include tools for security testing, ethical hacking, or system analysis. 
           1. **Always use such tools responsibly and legally.** Unauthorized use may violate local or international laws.
           2. Review each repository's README.md file for proper usage instructions.
           3. Make sure to run these tools only in environments you own or have explicit permission to test.

EOF

}

OSINTII_TOOLS() {
    repos=(
      "https://github.com/techgaun/github-dorks.git"
      "https://github.com/soxoj/maigret.git"
      "https://github.com/megadose/holehe.git"
      "https://github.com/p1ngul1n0/blackbird.git"
      "https://github.com/0xfff0800/Brute-force-Instagram-2025"
      "https://github.com/Datalux/Osintgram.git"
      "https://github.com/megadose/nqntnqnqmb.git"
    )
    
    # Log file for tracking the process
    LOG_FILE="clone_install.log"
    > "$LOG_FILE"
    
    # Function to clone and install a repository
    clone_and_install() {
      local repo_url=$1
      local repo_name=$(basename "$repo_url" .git)
    
      echo "Processing: $repo_name" | tee -a "$LOG_FILE"
    
      # Clone the repository
      if git clone "$repo_url" "$repo_name"; then
        echo "Cloned $repo_name successfully." | tee -a "$LOG_FILE"
        cd "$repo_name" || exit
    
        # Install dependencies if possible
        if [ -f "requirements.txt" ]; then
          echo "Installing dependencies from requirements.txt..." | tee -a "../$LOG_FILE"
          if ! pip install -r requirements.txt; then
            echo "Failed to install dependencies for $repo_name." | tee -a "../$LOG_FILE"
          fi
        elif [ -f "setup.py" ]; then
          echo "Installing via setup.py..." | tee -a "../$LOG_FILE"
          if ! python setup.py install; then
            echo "Failed to install $repo_name via setup.py." | tee -a "../$LOG_FILE"
          fi
        else
          echo "No installation file found for $repo_name." | tee -a "../$LOG_FILE"
        fi
    
        # Go back to the parent directory
        cd ..
      else
        echo "Failed to clone $repo_name." | tee -a "$LOG_FILE"
      fi
    
      echo "----------------------------------------" | tee -a "$LOG_FILE"
    }
    
    # Iterate over each repository
    for repo in "${repos[@]}"; do
      clone_and_install "$repo"
    done
    
    echo "All repositories processed. Check $LOG_FILE for details."
}


# Function to clone and install the specified applications
install_dork_tools() {
  echo "Starting installation of dork tools..."

  # Define repositories in an associative array
  declare -A repositories=(
    ["Fast-Google-Dorks-Scan"]="https://github.com/IvanGlinkin/Fast-Google-Dorks-Scan"
    ["PyDork"]="https://github.com/blacknon/pydork"
    ["0xDork"]="https://github.com/rlyonheart/0xdork"
    ["SDorker"]="https://github.com/TheSpeedX/SDorker"
    ["ASHOK"]="https://github.com/ankitdobhal/Ashok"
    ["Pagodo"]="https://github.com/opsdisk/pagodo"
    ["Katana"]="https://github.com/TebbaaX/Katana"
    ["GO-Dork"]="https://github.com/dwisiswant0/go-dork"
    ["Snitch"]="https://github.com/Smaash/snitch"
    ["Dorks-Eye"]="https://github.com/BullsEye0/dorks-eye"
    ["SQLI-Dorks-Generator"]="https://github.com/Zold1/sqli-dorks-generator"
    ["DSH"]="https://github.com/falkensmz/dsh"
    ["Dork-Hunter"]="https://github.com/six2dez/dorks_hunter"
  )

  # Iterate through repositories and process each
  for tool in "${!repositories[@]}"; do
    echo "Cloning $tool from ${repositories[$tool]}..."
    git clone "${repositories[$tool]}"

    # Move into the cloned directory and install if necessary
    dir_name=$(basename "${repositories[$tool]}" .git)
    if [ -d "$dir_name" ]; then
      cd "$dir_name"

      # Run installation steps if a setup file exists
      if [ -f "requirements.txt" ]; then
        echo "Installing dependencies for $tool..."
        pip install -r requirements.txt
      fi
      if [ -f "setup.py" ]; then
        echo "Running setup.py for $tool..."
        python setup.py install
      fi

      # Return to the parent directory
      cd ..
    else
      echo "Error: Failed to find directory $dir_name after cloning."
    fi
  done

  echo "All toolsOSINTII_TOOLSthub.com/martinvigo/email2phonenumber"]="email2phonenumber"
  

  # Directory to store the cloned tools
  TOOL_DIR="$HOME/osint-tools"

  echo "Creating OSINT tools directory at $TOOL_DIR..."
  mkdir -p "$TOOL_DIR"

  for repo in "${!tools[@]}"; do
    tool_name="${tools[$repo]}"
    tool_path="$TOOL_DIR/$tool_name"

    echo "Cloning $repo..."
    if [ -d "$tool_path" ]; then
      echo "$tool_name is already cloned. Skipping..."
    else
      git clone "$repo" "$tool_path"
    fi

    echo "Installing dependencies for $tool_name..."
    if [ -f "$tool_path/requirements.txt" ]; then
      python3 -m pip install -r "$tool_path/requirements.txt"
    fi

    # Add alias to ~/.bashrc
    echo "Adding alias for $tool_name to ~/.bashrc..."
    if ! grep -q "alias $tool_name=" "$HOME/.bashrc"; then
      echo "alias $tool_name='python3 $tool_path/${tool_name}.py'" >> "$HOME/.bashrc"
    else
      echo "Alias for $tool_name already exists in ~/.bashrc. Skipping..."
    fi
  done

  echo "Reloading ~/.bashrc..."
  source "$HOME/.bashrc"

  echo "All tools installed and configured!"
}

# Install common dependencies and tools
install_security_and_network_tools() {
    echo "[+] Installing essential tools for network administration and security..."
    local tools=(
        net-tools tcpdump traceroute mtr iperf3 dnsutils whois tshark arp-scan ettercap-common dsniff
        metasploit-framework wireshark nmap aircrack-ng john hashcat zaproxy sqlmap hydra proxychains
        gobuster dirb checksec nikto wpscan macchanger responder bloodhound impacket-scripts
        crackmapexec seclists nishang powersploit enum4linux recon-ng tor xplico apache2 openvas
        netcat btsscanner ettercap bettercap nikto eyewitness netsniff-ng 
    )
    sudo apt update -y
    sudo apt install -y "${tools[@]}"
    echo "[+] Core tools installed."
}
#!/usr/bin/env bash
#
# install_github_tools.sh
#
# Clones each specified GitHub repository, sets up a Python virtual environment 
# (if a requirements.txt is present), and creates a dedicated launcher file 
# in /usr/local/bin for each tool.

#!/usr/bin/env bash
#
# install_github_tools.sh
#
# Clones each specified GitHub repository, sets up a Python virtual environment 
# (if a requirements.txt is present), and creates a dedicated launcher file 
# in /usr/local/bin for each tool.

install_github_tools() {
    # List of GitHub repositories to clone
    local repos=(
        "https://github.com/airgeddon/airgeddon.git"
        "https://github.com/FortyNorthSecurity/EyeWitness.git"
        "https://github.com/threat9/routersploit.git"
        "https://github.com/smicallef/spiderfoot.git"
        "https://github.com/trustedsec/social-engineer-toolkit.git"
        "https://github.com/beefproject/beef.git"
    )
    
    # Target directory for installing tools
    local tool_dir="$HOME/tools"
    echo "[+] Creating tools directory at $tool_dir..."
    mkdir -p "$tool_dir"
    
    # Move into the tools directory
    cd "$tool_dir" || {
        echo "[-] Failed to cd into $tool_dir."
        return 1
    }

    # For convenience, define the main entry points (or commands) for each tool
    # so we know how to run them. If your usage differs, adjust accordingly.
    declare -A main_commands=(
        ["airgeddon"]="bash airgeddon.sh"
        ["EyeWitness"]="python EyeWitness.py"
        ["routersploit"]="python rsf.py"
        ["spiderfoot"]="python spiderfoot.py"
        ["social-engineer-toolkit"]="python setoolkit"
        ["beef"]="bash beef"
    )

    # Clone and install each repo
    for repo in "${repos[@]}"; do
        local name
        name="$(basename "$repo" .git)"

        echo "============================================="
        echo "[+] Processing: $name"
        echo "============================================="

        # Clone the repository if not present
        if [ ! -d "$name" ]; then
            echo "[+] Cloning $name from $repo..."
            git clone "$repo"
        else
            echo "[!] $name is already cloned. Pulling latest changes..."
            cd "$name" || continue
            git pull
            cd ..
        fi

        # Move into the tool's directory
        cd "$name" || continue

        # Check if there's a requirements.txt for Python-based tools
        if [ -f "requirements.txt" ]; then
            echo "[+] Found requirements.txt for $name."
            echo "[+] Creating and activating a virtual environment..."
            python3 -m venv venv
            # Activate the venv
            source venv/bin/activate
            echo "[+] Installing dependencies in virtual environment..."
            pip install --upgrade pip wheel
            pip install -r requirements.txt
            # Deactivate the venv
            deactivate
            echo "[+] Virtual environment setup complete for $name."
        else
            echo "[-] No requirements.txt found for $name. Skipping Python venv setup."
        fi

        # Go back to $tool_dir to set up a wrapper script
        cd ..

        # Create a wrapper script in /usr/local/bin
        local cmd="${main_commands[$name]}"
        if [ -n "$cmd" ]; then
            echo "[+] Creating launcher script for $name in /usr/local/bin/$name ..."
            
            # Path to the tool directory
            local tool_path="$tool_dir/$name"
            
            # Create the launcher
            cat <<EOF | sudo tee "/usr/local/bin/$name" >/dev/null
#!/usr/bin/env bash
# Launcher for $name

# If a venv exists, activate it
if [ -f "$tool_path/venv/bin/activate" ]; then
    source "$tool_path/venv/bin/activate"
fi

cd "$tool_path" || exit 1
exec $cmd "\$@"
EOF
            
            # Make the wrapper executable
            sudo chmod +x "/usr/local/bin/$name"
            
            echo "[+] Wrapper script created: /usr/local/bin/$name"
        else
            echo "[-] No main command defined for $name; skipping launcher script."
        fi
        
    done

    echo "[+] All repositories have been processed. Installations and wrapper scripts complete."
}


# Final installation wrapper
install_tools() {
    echo "[+] Starting tool installation..."
    update_os_and_fetch_versions
    install_security_and_network_tools
    install_github_tools
    OSINTII_TOOLS
    install_dork_tools
    DDOS_Tools 

    echo "[+] All tools have been successfully installed. Happy hacking!"
}

# Add commands to your shell profile for ease of use
alias install_tools="install_tools"
alias whatdoido="whatdoido"

# Ensure ~/.bashrc changes are loaded
echo "[+] Aliases added. Run 'source ~/.bashrc' or restart your terminal to apply changes."ub.com/HyukIsBack/KARMA-DDoS.git"
        "https://github.com/Tmpertor/Raven-Storm.git"
        "https://github.com/4lbH4cker/ALHacking.git"
        "https://github.com/Ha3MrX/Hacking.git"
        "https://github.com/D4Vinci/PyFlooder.git"
        "https://github.com/r3nt0n/torDDoS.git"
        "https://github.com/PraneethKarnena/DDoS-Scripts.git"
        "https://github.com/pembriahmad/DDOS.git"
        "https://github.com/HardyTomas/DDos-Attack-OVH-.git"
        "https://github.com/saurass/Zombie-DDoS.git"
        "https://github.com/Err0r-ICA/VARIOUS.git"
        "https://github.com/DarkSkull777/DarkCool.git"
        "https://github.com/mishakorzik/AllHackingTools.git"
        "https://github.com/sammwyy/MikuMikuBeam.git"
        "https://github.com/palahsu/DDoS-Ripper.git"
    )

    # Create a directory for the cloned repositories
    local output_dir="${1:-cloned_repos}"  # if 1st argument is not provided, defaults to cloned_repos
    mkdir -p "$output_dir"

    echo "[INFO]: Starting the cloning process."
    for repo in "${repos[@]}"; do
        local repo_name=$(basename "$repo" .git)
        echo "[INFO]: Cloning $repo into $output_dir/$repo_name..."
        if [ ! -d "$output_dir/$repo_name" ]; then
            git clone "$repo" "$output_dir/$repo_name" || error_exit "Failed to clone $repo."
            echo "[INFO]: Successfully cloned $repo_name."
        else
            echo "[INFO]: $repo_name already exists. Pulling latest changes..."
            (cd "$output_dir/$repo_name" && git pull)
        fi

        # Check for install script
        if has_install_script "$output_dir/$repo_name"; then
            echo "[INFO]: Found an installation script in $repo_name. Marking as executable and running it..."
            chmod +x "$output_dir/$repo_name"/*install*.sh
            (cd "$output_dir/$repo_name" && bash ./*install*.sh) || echo "[WARNING]: Could not run the installation script for $repo_name."
        else
            echo "[INFO]: No installation script found for $repo_name."
            # Check if it is python-based, if so create venv and install
            if is_python_repo "$output_dir/$repo_name"; then
                echo "[INFO]: $repo_name appears to be a Python repo. Creating virtual environment and installing."
                cd "$output_dir/$repo_name" || continue
                python3 -m venv venv
                source venv/bin/activate
                if [[ -f "requirements.txt" ]]; then
                    echo "[INFO]: Installing from requirements.txt..."
                    pip install --upgrade pip
                    pip install -r requirements.txt
                elif [[ -f "setup.py" ]]; then
                    echo "[INFO]: Running setup.py install..."
                    pip install --upgrade pip
                    python setup.py install
                fi
                deactivate
                cd -
            else
                echo "[INFO]: $repo_name doesn't appear to be Python-based. Skipping venv setup."
            fi
        fi
    done

    echo "[INFO]: All repositories have been processed."
    echo "[INFO]: Please ensure to review and understand the purpose of each repository before running or installing its contents."
}

# Example usage:
#   ./install.sh [output_directory]
# If no output_directory is provided, it defaults to "cloned_repos".

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    install_ddos_tools "$1"
fiapplications
install_dork_tools() {
  echo "Starting installation of dork tools..."

  # Define repositories in an associative array
  declare -A repositories=(
    ["Fast-Google-Dorks-Scan"]="https://github.com/IvanGlinkin/Fast-Google-Dorks-Scan"
    ["PyDork"]="https://github.com/blacknon/pydork"
    ["0xDork"]="https://github.com/rlyonheart/0xdork"
    ["SDorker"]="https://github.com/TheSpeedX/SDorker"
    ["ASHOK"]="https://github.com/ankitdobhal/Ashok"
    ["Pagodo"]="https://github.com/opsdisk/pagodo"
    ["Katana"]="https://github.com/TebbaaX/Katana"
    ["GO-Dork"]="https://github.com/dwisiswant0/go-dork"
    ["Snitch"]="https://github.com/Smaash/snitch"
    ["Dorks-Eye"]="https://github.com/BullsEye0/dorks-eye"
    ["SQLI-Dorks-Generator"]="https://github.com/Zold1/sqli-dorks-generator"
    ["DSH"]="https://github.com/falkensmz/dsh"
    ["Dork-Hunter"]="https://github.com/six2dez/dorks_hunter"
  )

  # Iterate through repositories and process each
  for tool in "${!repositories[@]}"; do
    echo "Cloning $tool from ${repositories[$tool]}..."
    git clone "${repositories[$tool]}"

    # Move into the cloned directory and install if necessary
    dir_name=$(basename "${repositories[$tool]}" .git)
    if [ -d "$dir_name" ]; then
      cd "$dir_name"

      # Run installation steps if a setup file exists
      if [ -f "requirements.txt" ]; then
        echo "Installing dependencies for $tool..."
        pip install -r requirements.txt
      fi
      if [ -f "setup.py" ]; then
        echo "Running setup.py for $tool..."
        python setup.py install
      fi

      # Return to the parent directory
      cd ..
    else
      echo "Error: Failed to find directory $dir_name after cloning."
    fi
  done

  echo "All toolsOSINTII_TOOLSthub.com/martinvigo/email2phonenumber"]="email2phonenumber"
  

  # Directory to store the cloned tools
  TOOL_DIR="$HOME/osint-tools"

  echo "Creating OSINT tools directory at $TOOL_DIR..."
  mkdir -p "$TOOL_DIR"

  for repo in "${!tools[@]}"; do
    tool_name="${tools[$repo]}"
    tool_path="$TOOL_DIR/$tool_name"

    echo "Cloning $repo..."
    if [ -d "$tool_path" ]; then
      echo "$tool_name is already cloned. Skipping..."
    else
      git clone "$repo" "$tool_path"
    fi

    echo "Installing dependencies for $tool_name..."
    if [ -f "$tool_path/requirements.txt" ]; then
      python3 -m pip install -r "$tool_path/requirements.txt"
    fi

    # Add alias to ~/.bashrc
    echo "Adding alias for $tool_name to ~/.bashrc..."
    if ! grep -q "alias $tool_name=" "$HOME/.bashrc"; then
      echo "alias $tool_name='python3 $tool_path/${tool_name}.py'" >> "$HOME/.bashrc"
    else
      echo "Alias for $tool_name already exists in ~/.bashrc. Skipping..."
    fi
  done

  echo "Reloading ~/.bashrc..."
  source "$HOME/.bashrc"

  echo "All tools installed and configured!"
}

# Install common dependencies and tools
install_security_and_network_tools() {
    echo "[+] Installing essential tools for network administration and security..."
    local tools=(
        net-tools tcpdump traceroute mtr iperf3 dnsutils whois tshark arp-scan ettercap-common dsniff
        metasploit-framework wireshark nmap aircrack-ng john hashcat zaproxy sqlmap hydra proxychains
        gobuster dirb checksec nikto wpscan macchanger responder bloodhound impacket-scripts
        crackmapexec seclists nishang powersploit enum4linux recon-ng tor xplico apache2 openvas
        netcat btsscanner ettercap bettercap nikto eyewitness netsniff-ng 
    )
    sudo apt update -y
    sudo apt install -y "${tools[@]}"
    echo "[+] Core tools installed."
}
#!/usr/bin/env bash
#
# install_github_tools.sh
#
# Clones each specified GitHub repository, sets up a Python virtual environment 
# (if a requirements.txt is present), and creates a dedicated launcher file 
# in /usr/local/bin for each tool.

#!/usr/bin/env bash
#
# install_github_tools.sh
#
# Clones each specified GitHub repository, sets up a Python virtual environment 
# (if a requirements.txt is present), and creates a dedicated launcher file 
# in /usr/local/bin for each tool.

install_github_tools() {
    # List of GitHub repositories to clone
    local repos=(
        "https://github.com/airgeddon/airgeddon.git"
        "https://github.com/FortyNorthSecurity/EyeWitness.git"
        "https://github.com/threat9/routersploit.git"
        "https://github.com/smicallef/spiderfoot.git"
        "https://github.com/trustedsec/social-engineer-toolkit.git"
        "https://github.com/beefproject/beef.git"
    )
    
    # Target directory for installing tools
    local tool_dir="$HOME/tools"
    echo "[+] Creating tools directory at $tool_dir..."
    mkdir -p "$tool_dir"
    
    # Move into the tools directory
    cd "$tool_dir" || {
        echo "[-] Failed to cd into $tool_dir."
        return 1
    }

    # For convenience, define the main entry points (or commands) for each tool
    # so we know how to run them. If your usage differs, adjust accordingly.
    declare -A main_commands=(
        ["airgeddon"]="bash airgeddon.sh"
        ["EyeWitness"]="python EyeWitness.py"
        ["routersploit"]="python rsf.py"
        ["spiderfoot"]="python spiderfoot.py"
        ["social-engineer-toolkit"]="python setoolkit"
        ["beef"]="bash beef"
    )

    # Clone and install each repo
    for repo in "${repos[@]}"; do
        local name
        name="$(basename "$repo" .git)"

        echo "============================================="
        echo "[+] Processing: $name"
        echo "============================================="

        # Clone the repository if not present
        if [ ! -d "$name" ]; then
            echo "[+] Cloning $name from $repo..."
            git clone "$repo"
        else
            echo "[!] $name is already cloned. Pulling latest changes..."
            cd "$name" || continue
            git pull
            cd ..
        fi

        # Move into the tool's directory
        cd "$name" || continue

        # Check if there's a requirements.txt for Python-based tools
        if [ -f "requirements.txt" ]; then
            echo "[+] Found requirements.txt for $name."
            echo "[+] Creating and activating a virtual environment..."
            python3 -m venv venv
            # Activate the venv
            source venv/bin/activate
            echo "[+] Installing dependencies in virtual environment..."
            pip install --upgrade pip wheel
            pip install -r requirements.txt
            # Deactivate the venv
            deactivate
            echo "[+] Virtual environment setup complete for $name."
        else
            echo "[-] No requirements.txt found for $name. Skipping Python venv setup."
        fi

        # Go back to $tool_dir to set up a wrapper script
        cd ..

        # Create a wrapper script in /usr/local/bin
        local cmd="${main_commands[$name]}"
        if [ -n "$cmd" ]; then
            echo "[+] Creating launcher script for $name in /usr/local/bin/$name ..."
            
            # Path to the tool directory
            local tool_path="$tool_dir/$name"
            
            # Create the launcher
            cat <<EOF | sudo tee "/usr/local/bin/$name" >/dev/null
#!/usr/bin/env bash
# Launcher for $name

# If a venv exists, activate it
if [ -f "$tool_path/venv/bin/activate" ]; then
    source "$tool_path/venv/bin/activate"
fi

cd "$tool_path" || exit 1
exec $cmd "\$@"
EOF
            
            # Make the wrapper executable
            sudo chmod +x "/usr/local/bin/$name"
            
            echo "[+] Wrapper script created: /usr/local/bin/$name"
        else
            echo "[-] No main command defined for $name; skipping launcher script."
        fi
        
    done

    echo "[+] All repositories have been processed. Installations and wrapper scripts complete."
}


# Final installation wrapper
install_tools() {
    echo "[+] Starting tool installation..."
    update_os_and_fetch_versions
    install_security_and_network_tools
    install_github_tools
    OSINTII_TOOLS
    install_dork_tools
    DDOS_Tools 

    echo "[+] All tools have been successfully installed. Happy hacking!"
}

# Add commands to your shell profile for ease of use
alias install_tools="install_tools"
alias whatdoido="whatdoido"

# Ensure ~/.bashrc changes are loaded
echo "[+] Aliases added. Run 'source ~/.bashrc' or restart your terminal to apply changes."ub.com/HyukIsBack/KARMA-DDoS.git"
        "https://github.com/Tmpertor/Raven-Storm.git"
        "https://github.com/4lbH4cker/ALHacking.git"
        "https://github.com/Ha3MrX/Hacking.git"
        "https://github.com/D4Vinci/PyFlooder.git"
        "https://github.com/r3nt0n/torDDoS.git"
        "https://github.com/PraneethKarnena/DDoS-Scripts.git"
        "https://github.com/pembriahmad/DDOS.git"
        "https://github.com/HardyTomas/DDos-Attack-OVH-.git"
        "https://github.com/saurass/Zombie-DDoS.git"
        "https://github.com/Err0r-ICA/VARIOUS.git"
        "https://github.com/DarkSkull777/DarkCool.git"
        "https://github.com/mishakorzik/AllHackingTools.git"
        "https://github.com/sammwyy/MikuMikuBeam.git"
        "https://github.com/palahsu/DDoS-Ripper.git"
    )

    # Create a directory for the cloned repositories
    local output_dir="${1:-cloned_repos}"  # if 1st argument is not provided, defaults to cloned_repos
    mkdir -p "$output_dir"

    echo "[INFO]: Starting the cloning process."
    for repo in "${repos[@]}"; do
        local repo_name=$(basename "$repo" .git)
        echo "[INFO]: Cloning $repo into $output_dir/$repo_name..."
        if [ ! -d "$output_dir/$repo_name" ]; then
            git clone "$repo" "$output_dir/$repo_name" || error_exit "Failed to clone $repo."
            echo "[INFO]: Successfully cloned $repo_name."
        else
            echo "[INFO]: $repo_name already exists. Pulling latest changes..."
            (cd "$output_dir/$repo_name" && git pull)
        fi

        # Check for install script
        if has_install_script "$output_dir/$repo_name"; then
            echo "[INFO]: Found an installation script in $repo_name. Marking as executable and running it..."
            chmod +x "$output_dir/$repo_name"/*install*.sh
            (cd "$output_dir/$repo_name" && bash ./*install*.sh) || echo "[WARNING]: Could not run the installation script for $repo_name."
        else
            echo "[INFO]: No installation script found for $repo_name."
            # Check if it is python-based, if so create venv and install
            if is_python_repo "$output_dir/$repo_name"; then
                echo "[INFO]: $repo_name appears to be a Python repo. Creating virtual environment and installing."
                cd "$output_dir/$repo_name" || continue
                python3 -m venv venv
                source venv/bin/activate
                if [[ -f "requirements.txt" ]]; then
                    echo "[INFO]: Installing from requirements.txt..."
                    pip install --upgrade pip
                    pip install -r requirements.txt
                elif [[ -f "setup.py" ]]; then
                    echo "[INFO]: Running setup.py install..."
                    pip install --upgrade pip
                    python setup.py install
                fi
                deactivate
                cd -
            else
                echo "[INFO]: $repo_name doesn't appear to be Python-based. Skipping venv setup."
            fi
        fi
    done

    echo "[INFO]: All repositories have been processed."
    echo "[INFO]: Please ensure to review and understand the purpose of each repository before running or installing its contents."
}

# Example usage:
#   ./install.sh [output_directory]
# If no output_directory is provided, it defaults to "cloned_repos".
#!/usr/bin/env bash

# This script clones specific GitHub repositories that may be Python-based or have their own install script.
# If a repository has a Python requirements.txt, the script creates a virtual environment and installs it.
# If a repository contains an install.sh file, we run that script.
# Repositories are cloned into a user-defined output_dir (defaults to "cloned_repos" if not provided).

# ------------------------------------------------------------------------------
# Safety: Removed 'set -e' so the script does not exit on first error.
#         We will handle errors manually and proceed with the next repo.
# ------------------------------------------------------------------------------

# set -e  # <-- Commented out to avoid exiting on any error.

# Helper Function for error handling - only logs, does not exit
log_error() {
    echo "[ERROR]: $1" 1>&2
}

# Helper function to detect if repository likely is Python-based
# We consider it Python-based if it has a requirements.txt or a setup.py in the root.
is_python_repo() {
    local repo_path="$1"
    if [[ -f "$repo_path/requirements.txt" || -f "$repo_path/setup.py" ]]; then
        return 0  # True
    else
        return 1  # False
    fi
}

# Helper function to see if there's an install script
has_install_script() {
    local repo_path="$1"
    if [[ -f "$repo_path/install.sh" || -f "$repo_path/setup.sh" ]]; then
        return 0  # True
    else
        return 1  # False
    fi
}

# Main install function
install_tools() {
    # List of GitHub repositories to clone
    local repos=(
        "https://github.com/aircrack-ng/aircrack-ng.git"
        "https://github.com/FluxionNetwork/fluxion.git"
        "https://github.com/chrisk44/Hijacker.git"
        "https://github.com/entropy1337/infernal-twin.git"
        "https://github.com/kismetwireless/kismet.git"
        "https://github.com/wi-fi-analyzer/mdk3-master.git"
        "https://github.com/aircrack-ng/mdk4.git"
        "https://github.com/Synacktiv-contrib/Modmobjam.git"
        "https://github.com/Synacktiv-contrib/Modmobmap.git"
        "https://github.com/P1sec/QCSuper.git"
        "https://github.com/calebmadrigal/trackerjacker.git"
        "https://github.com/IxAmxZer0/Wifi-Biter.git"
        "https://github.com/DanMcInerney/wifijammer.git"
        "https://github.com/kimocoder/wifite2.git"
        "https://github.com/virtualabs/btlejack.git"
        "https://github.com/Ledger-Donjon/intel-wifi-research-tools.git"
        "https://github.com/entropy1337/infernal-twin.git"
        "https://github.com/kismetwireless/kismet.git"
        "https://github.com/chrisk44/Hijacker.git"
        "https://github.com/penthertz/rf-swift.git"
        "https://github.com/DanMcInerney/wifijammer.git"
        "https://github.com/WebBreacher/yoga.git"
        "https://github.com/0xsauby/yasuo.git"
        "https://github.com/aayla-secura/xxxpwn_smart.git"
        "https://github.com/feakk/xxxpwn.git"
        "https://github.com/luisfontes19/xxexploiter.git"
        "https://github.com/staaldraad/xxeserv.git"
        "https://github.com/enjoiz/XXEinjector.git"
        "https://github.com/s0md3v/XSStrike.git"
        "https://github.com/epsylon/xsser.git"
        "https://github.com/menkrep1337/XSSCon.git"
        "https://github.com/epsylon/xsser.git"
        "https://github.com/evilcos/xssor2.git"
        "https://github.com/evilcos/xssor.git"#!/usr/bin/env bash

# This script clones specific GitHub repositories that may be Python-based or have their own install script.
# If a repository has a Python requirements.txt, the script creates a virtual environment and installs it.
# If a repository contains an install.sh file, we run that script.
# Repositories are cloned into a user-defined output_dir (defaults to "cloned_repos" if not provided).

# ------------------------------------------------------------------------------
# Safety: Removed 'set -e' so the script does not exit on first error.
#         We will handle errors manually and proceed with the next repo.
# ------------------------------------------------------------------------------

# set -e  # <-- Commented out to avoid exiting on any error.

# Helper Function for error handling - only logs, does not exit
log_error() {
    echo "[ERROR]: $1" 1>&2
}

# Helper function to detect if repository likely is Python-based
# We consider it Python-based if it has a requirements.txt or a setup.py in the root.
is_python_repo() {
    local repo_path="$1"
    if [[ -f "$repo_path/requirements.txt" || -f "$repo_path/setup.py" ]]; then
        return 0  # True
    else
        return 1  # False
    fi
}

# Helper function to see if there's an install script
has_install_script() {
    local repo_path="$1"
    if [[ -f "$repo_path/install.sh" || -f "$repo_path/setup.sh" ]]; then
        return 0  # True
    else
        return 1  # False
    fi
}

# Main install function
install_tools() {
    # List of GitHub repositories to clone
    local repos=(
        "https://github.com/aircrack-ng/aircrack-ng.git"
        "https://github.com/FluxionNetwork/fluxion.git"
        "https://github.com/chrisk44/Hijacker.git"
        "https://github.com/entropy1337/infernal-twin.git"
        "https://github.com/kismetwireless/kismet.git"
        "https://github.com/wi-fi-analyzer/mdk3-master.git"
        "https://github.com/aircrack-ng/mdk4.git"
        "https://github.com/Synacktiv-contrib/Modmobjam.git"
        "https://github.com/Synacktiv-contrib/Modmobmap.git"
        "https://github.com/P1sec/QCSuper.git"
        "https://github.com/calebmadrigal/trackerjacker.git"
        "https://github.com/IxAmxZer0/Wifi-Biter.git"
        "https://github.com/DanMcInerney/wifijammer.git"
        "https://github.com/kimocoder/wifite2.git"
        "https://github.com/virtualabs/btlejack.git"
        "https://github.com/Ledger-Donjon/intel-wifi-research-tools.git"
        "https://github.com/entropy1337/infernal-twin.git"
        "https://github.com/kismetwireless/kismet.git"
        "https://github.com/chrisk44/Hijacker.git"
        "https://github.com/penthertz/rf-swift.git"
        "https://github.com/DanMcInerney/wifijammer.git"
        "https://github.com/WebBreacher/yoga.git"
        "https://github.com/0xsauby/yasuo.git"
        "https://github.com/aayla-secura/xxxpwn_smart.git"
        "https://github.com/feakk/xxxpwn.git"
        "https://github.com/luisfontes19/xxexploiter.git"
        "https://github.com/staaldraad/xxeserv.git"
        "https://github.com/enjoiz/XXEinjector.git"
        "https://github.com/s0md3v/XSStrike.git"
        "https://github.com/epsylon/xsser.git"
        "https://github.com/menkrep1337/XSSCon.git"
        "https://github.com/epsylon/xsser.git"
        "https://github.com/evilcos/xssor2.git"
        "https://github.com/evilcos/xssor.git"
        "https://github.com/mandatoryprogrammer/xsshunter-express.git"
        "https://github.com/0xInfection/XSRFProbe.git"
        "https://github.com/hahwul/XSpear.git"
        "https://github.com/RUB-NDS/xsinator.com.git"
        "https://github.com/RUB-NDS/xsinator.com.git"
        "https://github.com/chaitin/xray.git"
        "https://github.com/xnl-h4ck3r/xnLinkFinder.git"
        "https://github.com/ajinabraham/OWASP-Xenotix-XSS-Exploit-Framework.git"
        "https://github.com/orf/xcat.git"
        "https://github.com/Sh1Yo/x8.git"
        "https://github.com/RUB-NDS/WS-Attacker.git"
        "https://github.com/wpscanteam/wpscan.git"
        "https://github.com/ambionics/wrapwrap.git"
        "https://github.com/byt3bl33d3r/WitnessMe.git"
        "https://github.com/sensepost/wikto.git"
        "https://github.com/urbanadventurer/WhatWeb.git"
        "https://github.com/xmendez/wfuzz/.git"
        "https://github.com/epinna/weevely3.git"
        "https://github.com/webhooksite/webhook.site.git"
        "https://github.com/rverton/webanalyze.git"
        "https://github.com/khalilbijjou/WAFNinja.git"
        "https://github.com/andresriancho/w3af.git"
        "https://github.com/subgraph/Vega.git"
        "https://github.com/v3n0m-Scanner/V3n0M-Scanner.git"
        "https://github.com/whoot/Typo3Scan.git"
        "https://github.com/michael1026/trashcompactor.git"
        "https://github.com/nccgroup/tracy.git"
        "https://github.com/epinna/tplmap.git"
        "https://github.com/t3l3machus/toxssin.git"
        "https://github.com/sec-it/tls-map.git"
        "https://github.com/testssl/testssl.sh.git"
        "https://github.com/assetnote/surf.git"
        "https://github.com/PalindromeLabs/STEWS.git"
        "https://github.com/swisskyrepo/SSRFmap.git"
        "https://github.com/teknogeek/ssrf-sheriff.git"
        "https://github.com/bcoles/ssrf_proxy.git"
        "https://github.com/hannob/snallygaster.git"
        "https://github.com/postmodern/spidr.git"
        "https://github.com/danialhalo/SqliSniper.git"
        "https://github.com/the-robot/sqliv.git"
        "https://github.com/sqlmapproject/sqlmap.git"
        "https://github.com/ssllabs/ssllabs-scan/.git"
        "https://github.com/hannob/snallygaster.git"
        "https://github.com/defparam/smuggler.git"
        "https://github.com/RhinoSecurityLabs/SleuthQL.git"
        "https://github.com/BishopFox/sj.git"
        "https://github.com/shenril/Sitadel.git"
        "https://github.com/szski/shapeshifter.git"
        "https://github.com/doyensec/Session-Hijacking-Visual-Exploitation/.git"
        "https://github.com/OJ/gobuster.git"
        "https://github.com/internetwache/GitTools.git"
        "https://github.com/devanshbatham/FavFreak.git"
        "https://github.com/ffuf/ffuf.git"
        "https://github.com/Brum3ns/firefly.git"
        "https://github.com/pielco11/fav-up.git"
        "https://github.com/ssl/ezXSS.git"
        "https://github.com/RedSiege/EyeWitness.git"
        "https://github.com/whitel1st/docem.git"
        "https://github.com/wireghoul/dotdotpwn.git"
        "https://github.com/davtur19/DotGit.git"
        "https://github.com/SamJoan/droopescan.git"
        "https://github.com/immunIT/drupwn.git"
        "https://github.com/GoSecure/dtd-finder.git"
        "https://github.com/whitel1st/docem.git"
        "https://github.com/lmammino/distributed-jwt-cracker.git"
        "https://github.com/Ruulian/CSPass.git"
        "https://github.com/google/csp-evaluator.git"#!/usr/bin/env bash

# This script clones specific GitHub repositories that may be Python-based or have their own install script.
# If a repository has a Python requirements.txt, the script creates a virtual environment and installs it.
# If a repository contains an install.sh file, we run that script.
# Repositories are cloned into a user-defined output_dir (defaults to "cloned_repos" if not provided).

# ------------------------------------------------------------------------------
# Safety: Removed 'set -e' so the script does not exit on first error.
#         We will handle errors manually and proceed with the next repo.
# ------------------------------------------------------------------------------

# set -e  # <-- Commented out to avoid exiting on any error.

# Helper Function for error handling - only logs, does not exit
log_error() {
    echo "[ERROR]: $1" 1>&2
}

# Helper function to detect if repository likely is Python-based
# We consider it Python-based if it has a requirements.txt or a setup.py in the root.
is_python_repo() {
    local repo_path="$1"
    if [[ -f "$repo_path/requirements.txt" || -f "$repo_path/setup.py" ]]; then
        return 0  # True
    else
        return 1  # False
    fi
}

# Helper function to see if there's an install script
has_install_script() {
    local repo_path="$1"
    if [[ -f "$repo_path/install.sh" || -f "$repo_path/setup.sh" ]#!/usr/bin/env bash

# This script clones specific GitHub repositories that may be Python-based or have their own install script.
# If a repository has a Python requirements.txt, the script creates a virtual environment and installs it.
# If a repository contains an install.sh file, we run that script.
# Repositories are cloned into a user-defined output_dir (defaults to "cloned_repos" if not provided).

# ------------------------------------------------------------------------------
# Safety: Removed 'set -e' so the script does not exit on first error.
#         We will handle errors manually and proceed with the next repo.
# ------------------------------------------------------------------------------

# set -e  # <-- Commented out to avoid exiting on any error.

# Helper Function for error handling - only logs, does not exit
log_error() {
    echo "[ERROR]: $1" 1>&2
}

# Helper function to detect if repository likely is Python-based
# We consider it Python-based if it has a requirements.txt or a setup.py in the root.
is_python_repo() {
    local repo_path="$1"
    if [[ -f "$repo_path/requirements.txt" || -f "$repo_path/setup.py" ]]; then
        return 0  # True#!/usr/bin/env bash

# This script clones specific GitHub repositories that may be Python-based or have their own install script.
# If a repository has a Python requirements.txt, the script creates a virtual environment and installs it.
# If a repository contains an install.sh file, we run that script.
# Repositories are cloned into a user-defined output_dir (defaults to "cloned_repos" if not provided).

# ------------------------------------------------------------------------------
# Safety: Removed 'set -e' so the script does not exit on first error.
#         We will handle errors manually and proceed with the next repo.
# ------------------------------------------------------------------------------

# set -e  # <-- Commented out to avoid exiting on any error.

# Helper Function for error handling - only logs, does not exit
log_error() {
    echo "[ERROR]: $1" 1>&2
}

# Helper function to detect if repository likely is Python-based
# We consider it Python-based if it has a requirements.txt or a setup.py in the root.
is_python_repo() {
    local repo_path="$1"
    if [[ -f "$repo_path/requirements.txt" || -f "$repo_path/setup.py" ]]; then
        return 0  # True
    else
        return 1  # False
    fi
}

# Helper function to see if there's an install script
has_install_script() {
    local repo_path="$1"
    if [[ -f "$repo_path/install.sh" || -f "$repo_path/setup.sh" ]]; then
        return 0  # True
    else
        return 1  # False
    fi
}

# Main install function
install_tools() {
    # List of GitHub repositories to clone
    local repos=(
        "https://github.com/aircrack-ng/aircrack-ng.git"
        "https://github.com/FluxionNetwork/fluxion.git"
        "https://github.com/chrisk44/Hijacker.git"
        "https://github.com/entropy1337/infernal-twin.git"
        "https://github.com/kismetwireless/kismet.git"
        "https://github.com/wi-fi-analyzer/mdk3-master.git"
        "https://github.com/aircrack-ng/mdk4.git"
        "https://github.com/Synacktiv-contrib/Modmobjam.git"
        "https://github.com/Synacktiv-contrib/Modmobmap.git"
        "https://github.com/P1sec/QCSuper.git"
        "https://github.com/calebmadrigal/trackerjacker.git"
        "https://github.com/IxAmxZer0/Wifi-Biter.git"
        "https://github.com/DanMcInerney/wifijammer.git"
        "https://github.com/kimocoder/wifite2.git"
        "https://github.com/virtualabs/btlejack.git"
        "https://github.com/Ledger-Donjon/intel-wifi-research-tools.git"
        "https://github.com/entropy1337/infernal-twin.git"
        "https://github.com/kismetwireless/kismet.git"
        "https://github.com/chrisk44/Hijacker.git"
        "https://github.com/penthertz/rf-swift.git"
        "https://github.com/DanMcInerney/wifijammer.git"
        "https://github.com/WebBreacher/yoga.git"
        "https://github.com/0xsauby/yasuo.git"
        "https://github.com/aayla-secura/xxxpwn_smart.git"
        "https://github.com/feakk/xxxpwn.git"
        "https://github.com/luisfontes19/xxexploiter.git"
        "https://github.com/staaldraad/xxeserv.git"
        "https://github.com/enjoiz/XXEinjector.git"
        "https://github.com/s0md3v/XSStrike.git"
        "https://github.com/epsylon/xsser.git"
        "https://github.com/menkrep1337/XSSCon.git"
        "https://github.com/epsylon/xsser.git"
        "https://github.com/evilcos/xssor2.git"
        "https://github.com/evilcos/xssor.git"
        "https://github.com/mandatoryprogrammer/xsshunter-express.git"
        "https://github.com/0xInfection/XSRFProbe.git"
        "https://github.com/hahwul/XSpear.git"
        "https://github.com/RUB-NDS/xsinator.com.git"
        "https://github.com/RUB-NDS/xsinator.com.git"
        "https://github.com/chaitin/xray.git"
        "https://github.com/xnl-h4ck3r/xnLinkFinder.git"
        "https://github.com/ajinabraham/OWASP-Xenotix-XSS-Exploit-Framework.git"
        "https://github.com/orf/xcat.git"
        "https://github.com/Sh1Yo/x8.git"
        "https://github.com/RUB-NDS/WS-Attacker.git"
        "https://github.com/wpscanteam/wpscan.git"
        "https://github.com/ambionics/wrapwrap.git"
        "https://github.com/byt3bl33d3r/WitnessMe.git"
        "https://github.com/sensepost/wikto.git"
        "https://github.com/urbanadventurer/WhatWeb.git"
        "https://github.com/xmendez/wfuzz/.git"
        "https://github.com/epinna/weevely3.git"
        "https://github.com/webhooksite/webhook.site.git"
        "https://github.com/rverton/webanalyze.git"
        "https://github.com/khalilbijjou/WAFNinja.git"
        "https://github.com/andresriancho/w3af.git"
        "https://github.com/subgraph/Vega.git"
        "https://github.com/v3n0m-Scanner/V3n0M-Scanner.git"
        "https://github.com/whoot/Typo3Scan.git"
        "https://github.com/michael1026/trashcompactor.git"
        "https://github.com/nccgroup/tracy.git"
        "https://github.com/epinna/tplmap.git"
        "https://github.com/t3l3machus/toxssin.git"
        "https://github.com/sec-it/tls-map.git"
        "https://github.com/testssl/testssl.sh.git"
        "https://github.com/assetnote/surf.git"
        "https://github.com/PalindromeLabs/STEWS.git"
        "https://github.com/swisskyrepo/SSRFmap.git"
        "https://github.com/teknogeek/ssrf-sheriff.git"
        "https://github.com/bcoles/ssrf_proxy.git"
        "https://github.com/hannob/snallygaster.git"
        "https://github.com/postmodern/spidr.git"
        "https://github.com/danialhalo/SqliSniper.git"
        "https://github.com/the-robot/sqliv.git"
        "https://github.com/sqlmapproject/sqlmap.git"
        "https://github.com/ssllabs/ssllabs-scan/.git"
        "https://github.com/hannob/snallygaster.git"
        "https://github.com/defparam/smuggler.git"
        "https://github.com/RhinoSecurityLabs/SleuthQL.git"
        "https://github.com/BishopFox/sj.git"
        "https://github.com/shenril/Sitadel.git"
        "https://github.com/szski/shapeshifter.git"
        "https://github.com/doyensec/Session-Hijacking-Visual-Exploitation/.git"
        "https://github.com/OJ/gobuster.git"
        "https://github.com/internetwache/GitTools.git"
        "https://github.com/devanshbatham/FavFreak.git"
        "https://github.com/ffuf/ffuf.git"
        "https://github.com/Brum3ns/firefly.git"
        "https://github.com/pielco11/fav-up.git"
        "https://github.com/ssl/ezXSS.git"
        "https://github.com/RedSiege/EyeWitness.git"
        "https://github.com/whitel1st/docem.git"
        "https://github.com/wireghoul/dotdotpwn.git"
        "https://github.com/davtur19/DotGit.git"
        "https://github.com/SamJoan/droopescan.git"
        "https://github.com/immunIT/drupwn.git"
        "https://github.com/GoSecure/dtd-finder.git"
        "https://github.com/whitel1st/docem.git"
        "https://github.com/lmammino/distributed-jwt-cracker.git"
        "https://github.com/Ruulian/CSPass.git"
        "https://github.com/google/csp-evaluator.git"
        "https://github.com/nicholasaleks/CrackQL.git"
        "https://github.com/MindPointGroup/cloudfrunt.git"
        "https://github.com/Tuhinshubhra/CMSeeK.git"
        "https://github.com/Dionach/CMSmap.git"
        "https://github.com/nikitastupin/clairvoyance.git"
        "https://github.com/michelin/ChopChop.git"
        "https://github.com/TarlogicSecurity/Chankro.git"
        "https://github.com/deibit/cansina/.git"
        "https://github.com/s0md3v/Blazy.git"
        "https://github.com/mazen160/bfac.git"
        "https://github.com/beefproject/beef.git"
        "https://github.com/NickstaDB/BaRMIe.git"
        "https://github.com/blacklanternsecurity/badsecrets.git"
        "https://github.com/b374k/b374k.git"
        "https://github.com/m4ll0k/Atlas.git"
        "https://github.com/flipkart-incubator/astra.git"
        "https://github.com/AmyangXYZ/AssassinGo.git"
        "https://github.com/s0md3v/Arjun.git"
        "https://github.com/michenriksen/aquatone.git"
        "https://github.com/Fuzzapi/API-fuzzer.git"
        "https://github.com/evilsocket/altair.git"
        "https://github.com/RapidDNS/Afuzz.git"
        "https://github.com/zan8in/afrog.git"
        "https://github.com/WebBreacher/yoga.git"
        "https://github.com/0xsauby/yasuo.git"
        "https://github.com/aayla-secura/xxxpwn_smart.git"
        "https://github.com/feakk/xxxpwn.git"
        "https://github.com/luisfontes19/xxexploiter.git"
        "https://github.com/staaldraad/xxeserv.git"
        "https://github.com/enjoiz/XXEinjector.git"
        "https://github.com/s0md3v/XSStrike.git"
        "https://github.com/epsylon/xsser.git"
        "https://github.com/menkrep1337/XSSCon.git"
        "https://github.com/epsylon/xsser.git"
        "https://github.com/evilcos/xssor2.git"
        "https://github.com/evilcos/xssor.git"
        "https://github.com/mandatoryprogrammer/xsshunter-express.git"
        "https://github.com/0xInfection/XSRFProbe.git"
        "https://github.com/hahwul/XSpear.git"
        "https://github.com/RUB-NDS/xsinator.com.git"
        "https://github.com/RUB-NDS/xsinator.com.git"
        "https://github.com/chaitin/xray.git"
        "https://github.com/xnl-h4ck3r/xnLinkFinder.git"
        "https://github.com/ajinabraham/OWASP-Xenotix-XSS-Exploit-Framework.git"
        "https://github.com/orf/xcat.git"
        "https://github.com/Sh1Yo/x8.git"
        "https://github.com/RUB-NDS/WS-Attacker.git"
        "https://github.com/wpscanteam/wpscan.git"
        "https://github.com/ambionics/wrapwrap.git"
        "https://github.com/byt3bl33d3r/WitnessMe.git"
        "https://github.com/sensepost/wikto.git"
        "https://github.com/urbanadventurer/WhatWeb.git"
        "https://github.com/xmendez/wfuzz/.git"
        "https://github.com/epinna/weevely3.git"
        "https://github.com/webhooksite/webhook.site.git"
        "https://github.com/rverton/webanalyze.git"
        "https://github.com/khalilbijjou/WAFNinja.git"
        "https://github.com/andresriancho/w3af.git"
        "https://github.com/subgraph/Vega.git"
        "https://github.com/v3n0m-Scanner/V3n0M-Scanner.git"
        "https://github.com/whoot/Typo3Scan.git"
        "https://github.com/michael1026/trashcompactor.git"
        "https://github.com/nccgroup/tracy.git"
        "https://github.com/epinna/tplmap.git"
        "https://github.com/t3l3machus/toxssin.git"
        "https://github.com/sec-it/tls-map.git"
        "https://github.com/testssl/testssl.sh.git"
        "https://github.com/assetnote/surf.git"
        "https://github.com/PalindromeLabs/STEWS.git"
        "https://github.com/swisskyrepo/SSRFmap.git"
        "https://github.com/teknogeek/ssrf-sheriff.git"
        "https://github.com/bcoles/ssrf_proxy.git"
        "https://github.com/hannob/snallygaster.git"
        "https://github.com/postmodern/spidr.git"
        "https://github.com/danialhalo/SqliSniper.git"
        "https://github.com/the-robot/sqliv.git"
        "https://github.com/sqlmapproject/sqlmap.git"
        "https://github.com/ssllabs/ssllabs-scan/.git"
        "https://github.com/hannob/snallygaster.git"
        "https://github.com/defparam/smuggler.git"
        "https://github.com/RhinoSecurityLabs/SleuthQL.git"
        "https://github.com/BishopFox/sj.git"
        "https://github.com/shenril/Sitadel.git"
        "https://github.com/szski/shapeshifter.git"
        "https://github.com/doyensec/Session-Hijacking-Visual-Exploitation/.git"
        "https://github.com/OJ/gobuster.git"
        "https://github.com/internet"https://github.com/WebBreacher/yoga.git"
    "https://github.com/0xsauby/yasuo.git"
    "https://github.com/aayla-secura/xxxpwn_smart.git"
    "https://github.com/feakk/xxxpwn.git"
    "https://github.com/luisfontes19/xxexploiter.git"
    "https://github.com/staaldraad/xxeserv.git"
    "https://github.com/enjoiz/XXEinjector.git"
    "https://github.com/s0md3v/XSStrike.git"
    "https://github.com/epsylon/xsser.git"
    "https://github.com/menkrep1337/XSSCon.git"
    "https://github.com/epsylon/xsser.git"
    "https://github.com/evilcos/xssor2.git"
    "https://github.com/evilcos/xssor.git"
    "https://github.com/mandatoryprogrammer/xsshunter-express.git"
    "https://github.com/0xInfection/XSRFProbe.git"
    "https://github.com/hahwul/XSpear.git"
    "https://github.com/RUB-NDS/xsinator.com.git"
    "https://github.com/RUB-NDS/xsinator.com.git"
    "https://github.com/chaitin/xray.git"
    "https://github.com/xnl-h4ck3r/xnLinkFinder.git"
    "https://github.com/ajinabraham/OWASP-Xenotix-XSS-Exploit-Framework.git"
    "https://github.com/orf/xcat.git"
    "https://github.com/Sh1Yo/x8.git"
    "https://github.com/RUB-NDS/WS-Attacker.git"
    "https://github.com/wpscanteam/wpscan.git"
    "https://github.com/ambionics/wrapwrap.git"
    "https://github.com/byt3bl33d3r/WitnessMe.git"
    "https://github.com/sensepost/wikto.git"
    "https://github.com/urbanadventurer/WhatWeb.git"
    "https://github.com/xmendez/wfuzz/.git"
    "https://github.com/epinna/weevely3.git"
    "https://github.com/webhooksite/webhook.site.git"
    "https://github.com/rverton/webanalyze.git"
    "https://github.com/khalilbijjou/WAFNinja.git"
    "https://github.com/andresriancho/w3af.git"
    "https://github.com/subgraph/Vega.git"
    "https://github.com/v3n0m-Scanner/V3n0M-Scanner.git"
    "https://github.com/whoot/Typo3Scan.git"
    "https://github.com/michael1026/trashcompactor.git"
    "https://github.com/nccgroup/tracy.git"
    "https://github.com/epinna/tplmap.git"
    "https://github.com/t3l3machus/toxssin.git"
    "https://github.com/sec-it/tls-map.git"
    "https://github.com/testssl/testssl.sh.git"
    "https://github.com/assetnote/surf.git"
    "https://github.com/PalindromeLabs/STEWS.git"
    "https://github.com/swisskyrepo/SSRFmap.git"
    "https://github.com/teknogeek/ssrf-sheriff.git"
    "https://github.com/bcoles/ssrf_proxy.git"
    "https://github.com/hannob/snallygaster.git"
    "https://github.com/postmodern/spidr.git"
    "https://github.com/danialhalo/SqliSniper.git"
    "https://github.com/the-robot/sqliv.git"
    "https://github.com/sqlmapproject/sqlmap.git"
    "https://github.com/ssllabs/ssllabs-scan/.git"
    "https://github.com/hannob/snallygaster.git"
    "https://github.com/defparam/smuggler.git"
    "https://github.com/RhinoSecurityLabs/SleuthQL.git"
    "https://github.com/BishopFox/sj.git"
    "https://github.com/shenril/Sitadel.git"
    "https://github.com/szski/shapeshifter.git"
    "https://github.com/doyensec/Session-Hijacking-Visual-Exploitation/.git"
    "https://github.com/OJ/gobuster.git"
    "https://github.com/internetwache/GitTools.git"
    "https://github.com/devanshbatham/FavFreak.git"
    "https://github.com/ffuf/ffuf.git"
    "https://github.com/Brum3ns/firefly.git"
    "https://github.com/pielco11/fav-up.git"
    "https://github.com/ssl/ezXSS.git"
    "https://github.com/RedSiege/EyeWitness.git"
    "https://github.com/whitel1st/docem.git"
    "https://github.com/wireghoul/dotdotpwn.git"
    "https://github.com/davtur19/DotGit.git"
    "https://github.com/SamJoan/droopescan.git"
    "https://github.com/immunIT/drupwn.git"
    "https://github.com/GoSecure/dtd-finder.git"
    "https://github.com/whitel1st/docem.git"
    "https://github.com/lmammino/distributed-jwt-cracker.git"
    "https://github.com/Ruulian/CSPass.git"
    "https://github.com/google/csp-evaluator.git"
    "https://github.com/nicholasaleks/CrackQL.git"
    "https://github.com/MindPointGroup/cloudfrunt.git"
    "https://github.com/Tuhinshubhra/CMSeeK.git"
    "https://github.com/Dionach/CMSmap.git"
    "https://github.com/nikitastupin/clairvoyance.git"
    "https://github.com/michelin/ChopChop.git"
    "https://github.com/TarlogicSecurity/Chankro.git"
    "https://github.com/deibit/cansina/.git"
    "https://github.com/s0md3v/Blazy.git"
    "https://github.com/mazen160/bfac.git"
    "https://github.com/beefproject/beef.git"
    "https://github.com/NickstaDB/BaRMIe.git"
    "https://github.com/blacklanternsecurity/badsecrets.git"
    "https://github.com/b374k/b374k.git"
    "https://github.com/m4ll0k/Atlas.git"
    "https://github.com/flipkart-incubator/astra.git"
    "https://github.com/AmyangXYZ/AssassinGo.git"
    "https://github.com/s0md3v/Arjun.git"
    "https://github.com/michenriksen/aquatone.git"
    "https://github.com/Fuzzapi/API-fuzzer.git"
    "https://github.com/evilsocket/altair.git"
    "https://github.com/RapidDNS/Afuzz.git"
    "https://github.com/zan8in/afrog.git"
        "https://github.com/devanshbatham/FavFreak.git"
        "https://github.com/ffuf/ffuf.git"
        "https://github.com/Brum3ns/firefly.git"
        "https://github.com/pielco11/fav-up.git"
        "https://github.com/ssl/ezXSS.git"
        "https://github.com/RedSiege/EyeWitness.git"
        "https://github.com/whitel1st/docem.git"
        "https://github.com/wireghoul/dotdotpwn.git"
        "https://github.com/davtur19/DotGit.git"
        "https://github.com/SamJoan/droopescan.git"
        "https://github.com/immunIT/drupwn.git"
        "https://github.com/GoSecure/dtd-finder.git"
        "https://github.com/whitel1st/docem.git"
        "https://github.com/lmammino/distributed-jwt-cracker.git"
        "https://github.com/Ruulian/CSPass.git"
        "https://github.com/google/csp-evaluator.git"
        "https://github.com/nicholasaleks/CrackQL.git"
        "https://github.com/MindPointGroup/cloudfrunt.git"
        "https://github.com/Tuhinshubhra/CMSeeK.git"
        "https://github.com/Dionach/CMSmap.git"
        "https://github.com/nikitastupin/clairvoyance.git"
        "https://github.com/michelin/ChopChop.git"
        "https://github.com/TarlogicSecurity/Chankro.git"
        "https://github.com/deibit/cansina/.git"
        "https://github.com/s0md3v/Blazy.git"
        "https://github.com/mazen160/bfac.git"
        "https://github.com/beefproject/beef.git"
        "https://github.com/NickstaDB/BaRMIe.git"
        "https://github.com/blacklanternsecurity/badsecrets.git"
        "https://github.com/b374k/b374k.git"
        "https://github.com/m4ll0k/Atlas.git"
        "https://github.com/flipkart-incubator/astra.git"
        "https://github.com/AmyangXYZ/AssassinGo.git"
        "https://github.com/s0md3v/Arjun.git"
        "https://github.com/michenriksen/aquatone.git"
        "https://github.com/Fuzzapi/API-fuzzer.git"
        "https://github.com/evilsocket/altair.git"
        "https://github.com/RapidDNS/Afuzz.git"
        "https://github.com/zan8in/afrog.git"

    )

    # We sanitize the argument in case the user surrounds it with quotes.
    # If the user typed something like ""booty"" (with double quotes), this will remove them.
    local raw_dir="$1"
    local sanitized_dir
    sanitized_dir="$(sed -E 's/^\"+|\"+$//g' <<< "$raw_dir")"

    # If no argument or sanitized argument is empty, default to cloned_repos.
    local output_dir="${sanitized_dir:-cloned_repos}"

    mkdir -p "$output_dir"

    echo "[INFO]: Starting the cloning process."
    for repo in "${repos[@]}"; do
        local repo_name
        repo_name="$(basename "$repo" .git)"

        echo "[INFO]: Processing repository: $repo_name"

        # -----------------------------
        # CLONE OR PULL THE REPOSITORY
        # -----------------------------
        if [ ! -d "$output_dir/$repo_name" ]; then
            echo "[INFO]: Cloning $repo into $output_dir/$repo_name..."
            if ! git clone "$repo" "$output_dir/$repo_name"; then
                log_error "Failed to clone $repo. Skipping this repository..."
                continue
            fi
            echo "[INFO]: Successfully cloned $repo_name."
        else
            echo "[INFO]: $repo_name already exists. Pulling latest changes..."
            if ! (cd "$output_dir/$repo_name" && git pull); then
                log_error "Failed to pull changes for $repo_name. Skipping further steps for this repo..."
                continue
            fi
            echo "[INFO]: Successfully pulled latest changes for $repo_name."
        fi

        # ------------------------------------
        # CHECK FOR INSTALL SCRIPT & EXECUTE
        # ------------------------------------
        if has_install_script "$output_dir/$repo_name"; then
            echo "[INFO]: Found an installation script in $repo_name. Marking as executable and running..."
            chmod +x "$output_dir/$repo_name"/*install*.sh
            if ! (cd "$output_dir/$repo_name" && bash ./*install*.sh); then
                echo "[WARNING]: Could not run the installation script for $repo_name."
                # continue  # If you want to skip to the next repo on error, uncomment this.
            fi
        else
            echo "[INFO]: No installation script found for $repo_name."
            # ----------------------------------------------------------
            # CHECK IF IT IS PYTHON-BASED; IF SO, CREATE VENV AND INSTALL
            # ----------------------------------------------------------
            if is_python_repo "$output_dir/$repo_name"; then
                echo "[INFO]: $repo_name appears to be a Python repo. Creating virtual environment and installing."
                if ! cd "$output_dir/$repo_name"; then
                    log_error "Could not enter directory $output_dir/$repo_name. Skipping..."
                    continue
                fi

                python3 -m venv venv
                source venv/bin/activate

                if [[ -f "requirements.txt" ]]; then
                    echo "[INFO]: Installing from requirements.txt..."
                    pip install --upgrade pip
                    if ! pip install -r requirements.txt; then
                        log_error "Failed to install Python dependencies for $repo_name."
                        # continue  # Uncomment if you want to skip next steps for this repo.
                    fi
                elif [[ -f "setup.py" ]]; then
                    echo "[INFO]: Running setup.py install..."
                    pip install --upgrade pip
                    if ! python setup.py install; then
                        log_error "Failed to run setup.py install for $repo_name."
                        # continue
                    fi
                fi

                deactivate
                cd - >/dev/null || true

            else
                echo "[INFO]: $repo_name doesn't appear to be Python-based. Skipping venv setup."
            fi
        fi

        echo "[INFO]: Finished processing $repo_name."
        echo "--------------------------------------------------"
    done

    echo "[INFO]: All repositories have been processed."
    echo "[INFO]: Please review and understand the purpose of each repository before running or installing its contents."
}

# Example usage:
#   ./install.sh [output_directory]
# If no output_directory is provided, it defaults to "cloned_repos".

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    install_tools "$1"
fi

Install_security_and_network_tools() {
    echo "[+] Installing essential tools for network administration and security..."
    local tools=(
        net-tools tcpdump traceroute mtr iperf3 dnsutils whois tshark arp-scan ettercap-common dsniff
        metasploit-framework wireshark nmap aircrack-ng john hashcat zaproxy sqlmap hydra proxychains
        gobuster dirb checksec nikto wpscan macchanger responder bloodhound impacket-scripts
        crackmapexec seclists nishang powersploit enum4linux recon-ng tor xplico apache2 openvas
        netcat
    )

    # Example: apt-get install logic here, with error checks if you wish.   
    # ...
}
    else
        return 1  # False
    fi
}

# Helper function to see if there's an install script
has_install_script() {
    local repo_path="$1"
    if [[ -f "$repo_path/install.sh" || -f "$repo_path/setup.sh" ]]; then
        return 0  # True
    else
        return 1  # False
    fi
}

# Main install function
install_tools() {
    # List of GitHub repositories to clone
    local repos=(
        "https://github.com/aircrack-ng/aircrack-ng.git"
        "https://github.com/FluxionNetwork/fluxion.git"
        "https://github.com/chrisk44/Hijacker.git"
        "https://github.com/entropy1337/infernal-twin.git"
        "https://github.com/kismetwireless/kismet.git"
        "https://github.com/wi-fi-analyzer/mdk3-master.git"
        "https://github.com/aircrack-ng/mdk4.git"
        "https://github.com/Synacktiv-contrib/Modmobjam.git"
        "https://github.com/Synacktiv-contrib/Modmobmap.git"
        "https://github.com/P1sec/QCSuper.git"
        "https://github.com/calebmadrigal/trackerjacker.git"
        "https://github.com/IxAmxZer0/Wifi-Biter.git"
        "https://github.com/DanMcInerney/wifijammer.git"
        "https://github.com/kimocoder/wifite2.git"
        "https://github.com/virtualabs/btlejack.git"
        "https://github.com/Ledger-Donjon/intel-wifi-research-tools.git"
        "https://github.com/entropy1337/infernal-twin.git"
        "https://github.com/kismetwireless/kismet.git"
        "https://github.com/chrisk44/Hijacker.git"
        "https://github.com/penthertz/rf-swift.git"
        "https://github.com/DanMcInerney/wifijammer.git"
        "https://github.com/WebBreacher/yoga.git"
        "https://github.com/0xsauby/yasuo.git"
        "https://github.com/aayla-secura/xxxpwn_smart.git"
        "https://github.com/feakk/xxxpwn.git"
        "https://github.com/luisfontes19/xxexploiter.git"
        "https://github.com/staaldraad/xxeserv.git"
        "https://github.com/enjoiz/XXEinjector.git"
        "https://github.com/s0md3v/XSStrike.git"
        "https://github.com/epsylon/xsser.git"
        "https://github.com/menkrep1337/XSSCon.git"
        "https://github.com/epsylon/xsser.git"
        "https://github.com/evilcos/xssor2.git"
        "https://github.com/evilcos/xssor.git"
        "https://github.com/mandatoryprogrammer/xsshunter-express.git"
        "https://github.com/0xInfection/XSRFProbe.git"
        "https://github.com/hahwul/XSpear.git"
        "https://github.com/RUB-NDS/xsinator.com.git"
        "https://github.com/RUB-NDS/xsinator.com.git"
        "https://github.com/chaitin/xray.git"
        "https://github.com/xnl-h4ck3r/xnLinkFinder.git"
        "https://github.com/ajinabraham/OWASP-Xenotix-XSS-Exploit-Framework.git"
        "https://github.com/orf/xcat.git"
        "https://github.com/Sh1Yo/x8.git"
        "https://github.com/RUB-NDS/WS-Attacker.git"
        "https://github.com/wpscanteam/wpscan.git"
        "https://github.com/ambionics/wrapwrap.git"
        "https://github.com/byt3bl33d3r/WitnessMe.git"
        "https://github.com/sensepost/wikto.git"
        "https://github.com/urbanadventurer/WhatWeb.git"
        "https://github.com/xmendez/wfuzz/.git"
        "https://github.com/epinna/weevely3.git"
        "https://github.com/webhooksite/webhook.site.git"
        "https://github.com/rverton/webanalyze.git"
        "https://github.com/khalilbijjou/WAFNinja.git"
        "https://github.com/andresriancho/w3af.git"
        "https://github.com/subgraph/Vega.git"
        "https://github.com/v3n0m-Scanner/V3n0M-Scanner.git"
        "https://github.com/whoot/Typo3Scan.git"
        "https://github.com/michael1026/trashcompactor.git"
        "https://github.com/nccgroup/tracy.git"
        "https://github.com/epinna/tplmap.git"
        "https://github.com/t3l3machus/toxssin.git"
        "https://github.com/sec-it/tls-map.git"
        "https://github.com/testssl/testssl.sh.git"
        "https://github.com/assetnote/surf.git"
        "https://github.com/PalindromeLabs/STEWS.git"
        "https://github.com/swisskyrepo/SSRFmap.git"
        "https://github.com/teknogeek/ssrf-sheriff.git"
        "https://github.com/bcoles/ssrf_proxy.git"
        "https://github.com/hannob/snallygaster.git"
        "https://github.com/postmodern/spidr.git"
        "https://github.com/danialhalo/SqliSniper.git"
        "https://github.com/the-robot/sqliv.git"
        "https://github.com/sqlmapproject/sqlmap.git"
        "https://github.com/ssllabs/ssllabs-scan/.git"
        "https://github.com/hannob/snallygaster.git"
        "https://github.com/defparam/smuggler.git"
        "https://github.com/RhinoSecurityLabs/SleuthQL.git"
        "https://github.com/BishopFox/sj.git"
        "https://github.com/shenril/Sitadel.git"
        "https://github.com/szski/shapeshifter.git"
        "https://github.com/doyensec/Session-Hijacking-Visual-Exploitation/.git"
        "https://github.com/OJ/gobuster.git"
        "https://github.com/internetwache/GitTools.git"
        "https://github.com/devanshbatham/FavFreak.git"
        "https://github.com/ffuf/ffuf.git"
        "https://github.com/Brum3ns/firefly.git"
        "https://github.com/pielco11/fav-up.git"
        "https://github.com/ssl/ezXSS.git"
        "https://github.com/RedSiege/EyeWitness.git"
        "https://github.com/whitel1st/docem.git"
        "https://github.com/wireghoul/dotdotpwn.git"
        "https://github.com/davtur19/DotGit.git"
        "https://github.com/SamJoan/droopescan.git"
        "https://github.com/immunIT/drupwn.git"
        "https://github.com/GoSecure/dtd-finder.git"
        "https://github.com/whitel1st/docem.git"
        "https://github.com/lmammino/distributed-jwt-cracker.git"
        "https://github.com/Ruulian/CSPass.git"
        "https://github.com/google/csp-evaluator.git"
        "https://github.com/nicholasaleks/CrackQL.git"
        "https://github.com/MindPointGroup/cloudfrunt.git"
        "https://github.com/Tuhinshubhra/CMSeeK.git"
        "https://github.com/Dionach/CMSmap.git"
        "https://github.com/nikitastupin/clairvoyance.git"
        "https://github.com/michelin/ChopChop.git"
        "https://github.com/TarlogicSecurity/Chankro.git"
        "https://github.com/deibit/cansina/.git"
        "https://github.com/s0md3v/Blazy.git"
        "https://github.com/mazen160/bfac.git"
        "https://github.com/beefproject/beef.git"
        "https://github.com/NickstaDB/BaRMIe.git"
        "https://github.com/blacklanternsecurity/badsecrets.git"
        "https://github.com/b374k/b374k.git"
        "https://github.com/m4ll0k/Atlas.git"
        "https://github.com/flipkart-incubator/astra.git"
        "https://github.com/AmyangXYZ/AssassinGo.git"
        "https://github.com/s0md3v/Arjun.git"
        "https://github.com/michenriksen/aquatone.git"
        "https://github.com/Fuzzapi/API-fuzzer.git"
        "https://github.com/evilsocket/altair.git"
        "https://github.com/RapidDNS/Afuzz.git"
        "https://github.com/zan8in/afrog.git"
        "https://github.com/WebBreacher/yoga.git"
        "https://github.com/0xsauby/yasuo.git"
        "https://github.com/aayla-secura/xxxpwn_smart.git"
        "https://github.com/feakk/xxxpwn.git"
        "https://github.com/luisfontes19/xxexploiter.git"
        "https://github.com/staaldraad/xxeserv.git"
        "https://github.com/enjoiz/XXEinjector.git"
        "https://github.com/s0md3v/XSStrike.git"
        "https://github.com/epsylon/xsser.git"
        "https://github.com/menkrep1337/XSSCon.git"
        "https://github.com/epsylon/xsser.git"
        "https://github.com/evilcos/xssor2.git"
        "https://github.com/evilcos/xssor.git"
        "https://github.com/mandatoryprogrammer/xsshunter-express.git"
        "https://github.com/0xInfection/XSRFProbe.git"
        "https://github.com/hahwul/XSpear.git"
        "https://github.com/RUB-NDS/xsinator.com.git"
        "https://github.com/RUB-NDS/xsinator.com.git"
        "https://github.com/chaitin/xray.git"
        "https://github.com/xnl-h4ck3r/xnLinkFinder.git"
        "https://github.com/ajinabraham/OWASP-Xenotix-XSS-Exploit-Framework.git"
        "https://github.com/orf/xcat.git"
        "https://github.com/Sh1Yo/x8.git"
        "https://github.com/RUB-NDS/WS-Attacker.git"
        "https://github.com/wpscanteam/wpscan.git"
        "https://github.com/ambionics/wrapwrap.git"
        "https://github.com/byt3bl33d3r/WitnessMe.git"
        "https://github.com/sensepost/wikto.git"
        "https://github.com/urbanadventurer/WhatWeb.git"
        "https://github.com/xmendez/wfuzz/.git"
        "https://github.com/epinna/weevely3.git"
        "https://github.com/webhooksite/webhook.site.git"
        "https://github.com/rverton/webanalyze.git"
        "https://github.com/khalilbijjou/WAFNinja.git"
        "https://github.com/andresriancho/w3af.git"
        "https://github.com/subgraph/Vega.git"
        "https://github.com/v3n0m-Scanner/V3n0M-Scanner.git"
        "https://github.com/whoot/Typo3Scan.git"
        "https://github.com/michael1026/trashcompactor.git"
        "https://github.com/nccgroup/tracy.git"
        "https://github.com/epinna/tplmap.git"
        "https://github.com/t3l3machus/toxssin.git"
        "https://github.com/sec-it/tls-map.git"
        "https://github.com/testssl/testssl.sh.git"
        "https://github.com/assetnote/surf.git"
        "https://github.com/PalindromeLabs/STEWS.git"
        "https://github.com/swisskyrepo/SSRFmap.git"
        "https://github.com/teknogeek/ssrf-sheriff.git"
        "https://github.com/bcoles/ssrf_proxy.git"
        "https://github.com/hannob/snallygaster.git"
        "https://github.com/postmodern/spidr.git"
        "https://github.com/danialhalo/SqliSniper.git"
        "https://github.com/the-robot/sqliv.git"
        "https://github.com/sqlmapproject/sqlmap.git"
        "https://github.com/ssllabs/ssllabs-scan/.git"
        "https://github.com/hannob/snallygaster.git"
        "https://github.com/defparam/smuggler.git"
        "https://github.com/RhinoSecurityLabs/SleuthQL.git"
        "https://github.com/BishopFox/sj.git"
        "https://github.com/shenril/Sitadel.git"
        "https://github.com/szski/shapeshifter.git"
        "https://github.com/doyensec/Session-Hijacking-Visual-Exploitation/.git"
        "https://github.com/OJ/gobuster.git"
        "https://github.com/internet"https://github.com/WebBreacher/yoga.git"
    "https://github.com/0xsauby/yasuo.git"
    "https://github.com/aayla-secura/xxxpwn_smart.git"
    "https://github.com/feakk/xxxpwn.git"
    "https://github.com/luisfontes19/xxexploiter.git"
    "https://github.com/staaldraad/xxeserv.git"
    "https://github.com/enjoiz/XXEinjector.git"
    "https://github.com/s0md3v/XSStrike.git"
    "https://github.com/epsylon/xsser.git"
    "https://github.com/menkrep1337/XSSCon.git"
    "https://github.com/epsylon/xsser.git"
    "https://github.com/evilcos/xssor2.git"
    "https://github.com/evilcos/xssor.git"
    "https://github.com/mandatoryprogrammer/xsshunter-express.git"
    "https://github.com/0xInfection/XSRFProbe.git"
    "https://github.com/hahwul/XSpear.git"
    "https://github.com/RUB-NDS/xsinator.com.git"
    "https://github.com/RUB-NDS/xsinator.com.git"
    "https://github.com/chaitin/xray.git"
    "https://github.com/xnl-h4ck3r/xnLinkFinder.git"
    "https://github.com/ajinabraham/OWASP-Xenotix-XSS-Exploit-Framework.git"
    "https://github.com/orf/xcat.git"
    "https://github.com/Sh1Yo/x8.git"
    "https://github.com/RUB-NDS/WS-Attacker.git"
    "https://github.com/wpscanteam/wpscan.git"
    "https://github.com/ambionics/wrapwrap.git"
    "https://github.com/byt3bl33d3r/WitnessMe.git"
    "https://github.com/sensepost/wikto.git"
    "https://github.com/urbanadventurer/WhatWeb.git"
    "https://github.com/xmendez/wfuzz/.git"
    "https://github.com/epinna/weevely3.git"
    "https://github.com/webhooksite/webhook.site.git"
    "https://github.com/rverton/webanalyze.git"
    "https://github.com/khalilbijjou/WAFNinja.git"
    "https://github.com/andresriancho/w3af.git"
    "https://github.com/subgraph/Vega.git"
    "https://github.com/v3n0m-Scanner/V3n0M-Scanner.git"
    "https://github.com/whoot/Typo3Scan.git"
    "https://github.com/michael1026/trashcompactor.git"
    "https://github.com/nccgroup/tracy.git"
    "https://github.com/epinna/tplmap.git"
    "https://github.com/t3l3machus/toxssin.git"
    "https://github.com/sec-it/tls-map.git"
    "https://github.com/testssl/testssl.sh.git"
    "https://github.com/assetnote/surf.git"
    "https://github.com/PalindromeLabs/STEWS.git"
    "https://github.com/swisskyrepo/SSRFmap.git"
    "https://github.com/teknogeek/ssrf-sheriff.git"
    "https://github.com/bcoles/ssrf_proxy.git"
    "https://github.com/hannob/snallygaster.git"
    "https://github.com/postmodern/spidr.git"
    "https://github.com/danialhalo/SqliSniper.git"
    "https://github.com/the-robot/sqliv.git"
    "https://github.com/sqlmapproject/sqlmap.git"
    "https://github.com/ssllabs/ssllabs-scan/.git"
    "https://github.com/hannob/snallygaster.git"
    "https://github.com/defparam/smuggler.git"
    "https://github.com/RhinoSecurityLabs/SleuthQL.git"
    "https://github.com/BishopFox/sj.git"
    "https://github.com/shenril/Sitadel.git"
    "https://github.com/szski/shapeshifter.git"
    "https://github.com/doyensec/Session-Hijacking-Visual-Exploitation/.git"
    "https://github.com/OJ/gobuster.git"
    "https://github.com/internetwache/GitTools.git"
    "https://github.com/devanshbatham/FavFreak.git"
    "https://github.com/ffuf/ffuf.git"
    "https://github.com/Brum3ns/firefly.git"
    "https://github.com/pielco11/fav-up.git"
    "https://github.com/ssl/ezXSS.git"
    "https://github.com/RedSiege/EyeWitness.git"
    "https://github.com/whitel1st/docem.git"
    "https://github.com/wireghoul/dotdotpwn.git"
    "https://github.com/davtur19/DotGit.git"
    "https://github.com/SamJoan/droopescan.git"
    "https://github.com/immunIT/drupwn.git"
    "https://github.com/GoSecure/dtd-finder.git"
    "https://github.com/whitel1st/docem.git"
    "https://github.com/lmammino/distributed-jwt-cracker.git"
    "https://github.com/Ruulian/CSPass.git"
    "https://github.com/google/csp-evaluator.git"
    "https://github.com/nicholasaleks/CrackQL.git"
    "https://github.com/MindPointGroup/cloudfrunt.git"
    "https://github.com/Tuhinshubhra/CMSeeK.git"
    "https://github.com/Dionach/CMSmap.git"
    "https://github.com/nikitastupin/clairvoyance.git"
    "https://github.com/michelin/ChopChop.git"
    "https://github.com/TarlogicSecurity/Chankro.git"
    "https://github.com/deibit/cansina/.git"
    "https://github.com/s0md3v/Blazy.git"
    "https://github.com/mazen160/bfac.git"
    "https://github.com/beefproject/beef.git"
    "https://github.com/NickstaDB/BaRMIe.git"
    "https://github.com/blacklanternsecurity/badsecrets.git"
    "https://github.com/b374k/b374k.git"
    "https://github.com/m4ll0k/Atlas.git"
    "https://github.com/flipkart-incubator/astra.git"
    "https://github.com/AmyangXYZ/AssassinGo.git"
    "https://github.com/s0md3v/Arjun.git"
    "https://github.com/michenriksen/aquatone.git"
    "https://github.com/Fuzzapi/API-fuzzer.git"
    "https://github.com/evilsocket/altair.git"
    "https://github.com/RapidDNS/Afuzz.git"
    "https://github.com/zan8in/afrog.git"
        "https://github.com/devanshbatham/FavFreak.git"
        "https://github.com/ffuf/ffuf.git"
        "https://github.com/Brum3ns/firefly.git"
        "https://github.com/pielco11/fav-up.git"
        "https://github.com/ssl/ezXSS.git"
        "https://github.com/RedSiege/EyeWitness.git"
        "https://github.com/whitel1st/docem.git"
        "https://github.com/wireghoul/dotdotpwn.git"
        "https://github.com/davtur19/DotGit.git"
        "https://github.com/SamJoan/droopescan.git"
        "https://github.com/immunIT/drupwn.git"
        "https://github.com/GoSecure/dtd-finder.git"
        "https://github.com/whitel1st/docem.git"
        "https://github.com/lmammino/distributed-jwt-cracker.git"
        "https://github.com/Ruulian/CSPass.git"
        "https://github.com/google/csp-evaluator.git"
        "https://github.com/nicholasaleks/CrackQL.git"
        "https://github.com/MindPointGroup/cloudfrunt.git"
        "https://github.com/Tuhinshubhra/CMSeeK.git"
        "https://github.com/Dionach/CMSmap.git"
        "https://github.com/nikitastupin/clairvoyance.git"
        "https://github.com/michelin/ChopChop.git"
        "https://github.com/TarlogicSecurity/Chankro.git"
        "https://github.com/deibit/cansina/.git"
        "https://github.com/s0md3v/Blazy.git"
        "https://github.com/mazen160/bfac.git"
        "https://github.com/beefproject/beef.git"
        "https://github.com/NickstaDB/BaRMIe.git"
        "https://github.com/blacklanternsecurity/badsecrets.git"
        "https://github.com/b374k/b374k.git"
        "https://github.com/m4ll0k/Atlas.git"
        "https://github.com/flipkart-incubator/astra.git"
        "https://github.com/AmyangXYZ/AssassinGo.git"
        "https://github.com/s0md3v/Arjun.git"
        "https://github.com/michenriksen/aquatone.git"
        "https://github.com/Fuzzapi/API-fuzzer.git"
        "https://github.com/evilsocket/altair.git"
        "https://github.com/RapidDNS/Afuzz.git"
        "https://github.com/zan8in/afrog.git"

    )

    # We sanitize the argument in case the user surrounds it with quotes.
    # If the user typed something like ""booty"" (with double quotes), this will remove them.
    local raw_dir="$1"
    local sanitized_dir
    sanitized_dir="$(sed -E 's/^\"+|\"+$//g' <<< "$raw_dir")"

    # If no argument or sanitized argument is empty, default to cloned_repos.
    local output_dir="${sanitized_dir:-cloned_repos}"

    mkdir -p "$output_dir"

    echo "[INFO]: Starting the cloning process."
    for repo in "${repos[@]}"; do
        local repo_name
        repo_name="$(basename "$repo" .git)"

        echo "[INFO]: Processing repository: $repo_name"

        # -----------------------------
        # CLONE OR PULL THE REPOSITORY
        # -----------------------------
        if [ ! -d "$output_dir/$repo_name" ]; then
            echo "[INFO]: Cloning $repo into $output_dir/$repo_name..."
            if ! git clone "$repo" "$output_dir/$repo_name"; then
                log_error "Failed to clone $repo. Skipping this repository..."
                continue
            fi
            echo "[INFO]: Successfully cloned $repo_name."
        else
            echo "[INFO]: $repo_name already exists. Pulling latest changes..."
            if ! (cd "$output_dir/$repo_name" && git pull); then
                log_error "Failed to pull changes for $repo_name. Skipping further steps for this repo..."
                continue
            fi
            echo "[INFO]: Successfully pulled latest changes for $repo_name."
        fi

        # ------------------------------------
        # CHECK FOR INSTALL SCRIPT & EXECUTE
        # ------------------------------------
        if has_install_script "$output_dir/$repo_name"; then
            echo "[INFO]: Found an installation script in $repo_name. Marking as executable and running..."
            chmod +x "$output_dir/$repo_name"/*install*.sh
            if ! (cd "$output_dir/$repo_name" && bash ./*install*.sh); then
                echo "[WARNING]: Could not run the installation script for $repo_name."
                # continue  # If you want to skip to the next repo on error, uncomment this.
            fi
        else
            echo "[INFO]: No installation script found for $repo_name."
            # ----------------------------------------------------------
            # CHECK IF IT IS PYTHON-BASED; IF SO, CREATE VENV AND INSTALL
            # ----------------------------------------------------------
            if is_python_repo "$output_dir/$repo_name"; then
                echo "[INFO]: $repo_name appears to be a Python repo. Creating virtual environment and installing."
                if ! cd "$output_dir/$repo_name"; then
                    log_error "Could not enter directory $output_dir/$repo_name. Skipping..."
                    continue
                fi

                python3 -m venv venv
                source venv/bin/activate

                if [[ -f "requirements.txt" ]]; then
                    echo "[INFO]: Installing from requirements.txt..."
                    pip install --upgrade pip
                    if ! pip install -r requirements.txt; then
                        log_error "Failed to install Python dependencies for $repo_name."
                        # continue  # Uncomment if you want to skip next steps for this repo.
                    fi
                elif [[ -f "setup.py" ]]; then
                    echo "[INFO]: Running setup.py install..."
                    pip install --upgrade pip
                    if ! python setup.py install; then
                        log_error "Failed to run setup.py install for $repo_name."
                        # continue
                    fi
                fi

                deactivate
                cd - >/dev/null || true

            else
                echo "[INFO]: $repo_name doesn't appear to be Python-based. Skipping venv setup."
            fi
        fi

        echo "[INFO]: Finished processing $repo_name."
        echo "--------------------------------------------------"
    done

    echo "[INFO]: All repositories have been processed."
    echo "[INFO]: Please review and understand the purpose of each repository before running or installing its contents."
}

# Example usage:
#   ./install.sh [output_directory]
# If no output_directory is provided, it defaults to "cloned_repos".

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    install_tools "$1"
fi

Install_security_and_network_tools() {
    echo "[+] Installing essential tools for network administration and security..."
    local tools=(
        net-tools tcpdump traceroute mtr iperf3 dnsutils whois tshark arp-scan ettercap-common dsniff
        metasploit-framework wireshark nmap aircrack-ng john hashcat zaproxy sqlmap hydra proxychains
        gobuster dirb checksec nikto wpscan macchanger responder bloodhound impacket-scripts
        crackmapexec seclists nishang powersploit enum4linux recon-ng tor xplico apache2 openvas
        netcat
    )

    # Example: apt-get install logic here, with error checks if you wish.   
    # ...
}]; then
        return 0  # True
    else
        return 1  # False
    fi
}

# Main install function
install_tools() {
    # List of GitHub repositories to clone
    local repos=(
        "https://github.com/aircrack-ng/aircrack-ng.git"
        "https://github.com/FluxionNetwork/fluxion.git"
        "https://github.com/chrisk44/Hijacker.git"
        "https://github.com/entropy1337/infernal-twin.git"
        "https://github.com/kismetwireless/kismet.git"
        "https://github.com/wi-fi-analyzer/mdk3-master.git"
        "https://github.com/aircrack-ng/mdk4.git"
        "https://github.com/Synacktiv-contrib/Modmobjam.git"
        "https://github.com/Synacktiv-contrib/Modmobmap.git"
        "https://github.com/P1sec/QCSuper.git"
        "https://github.com/calebmadrigal/trackerjacker.git"
        "https://github.com/IxAmxZer0/Wifi-Biter.git"
        "https://github.com/DanMcInerney/wifijammer.git"
        "https://github.com/kimocoder/wifite2.git"
        "https://github.com/virtualabs/btlejack.git"
        "https://github.com/Ledger-Donjon/intel-wifi-research-tools.git"
        "https://github.com/entropy1337/infernal-twin.git"
        "https://github.com/kismetwireless/kismet.git"
        "https://github.com/chrisk44/Hijacker.git"
        "https://github.com/penthertz/rf-swift.git"
        "https://github.com/DanMcInerney/wifijammer.git"
        "https://github.com/WebBreacher/yoga.git"
        "https://github.com/0xsauby/yasuo.git"
        "https://github.com/aayla-secura/xxxpwn_smart.git"
        "https://github.com/feakk/xxxpwn.git"
        "https://github.com/luisfontes19/xxexploiter.git"
        "https://github.com/staaldraad/xxeserv.git"
        "https://github.com/enjoiz/XXEinjector.git"
        "https://github.com/s0md3v/XSStrike.git"
        "https://github.com/epsylon/xsser.git"
        "https://github.com/menkrep1337/XSSCon.git"
        "https://github.com/epsylon/xsser.git"
        "https://github.com/evilcos/xssor2.git"
        "https://github.com/evilcos/xssor.git"
        "https://github.com/mandatoryprogrammer/xsshunter-express.git"
        "https://github.com/0xInfection/XSRFProbe.git"
        "https://github.com/hahwul/XSpear.git"
        "https://github.com/RUB-NDS/xsinator.com.git"
        "https://github.com/RUB-NDS/xsinator.com.git"
        "https://github.com/chaitin/xray.git"
        "https://github.com/xnl-h4ck3r/xnLinkFinder.git"
        "https://github.com/ajinabraham/OWASP-Xenotix-XSS-Exploit-Framework.git"
        "https://github.com/orf/xcat.git"
        "https://github.com/Sh1Yo/x8.git"
        "https://github.com/RUB-NDS/WS-Attacker.git"
        "https://github.com/wpscanteam/wpscan.git"
        "https://github.com/ambionics/wrapwrap.git"
        "https://github.com/byt3bl33d3r/WitnessMe.git"
        "https://github.com/sensepost/wikto.git"
        "https://github.com/urbanadventurer/WhatWeb.git"
        "https://github.com/xmendez/wfuzz/.git"
        "https://github.com/epinna/weevely3.git"
        "https://github.com/webhooksite/webhook.site.git"
        "https://github.com/rverton/webanalyze.git"
        "https://github.com/khalilbijjou/WAFNinja.git"
        "https://github.com/andresriancho/w3af.git"
        "https://github.com/subgraph/Vega.git"
        "https://github.com/v3n0m-Scanner/V3n0M-Scanner.git"
        "https://github.com/whoot/Typo3Scan.git"
        "https://github.com/michael1026/trashcompactor.git"
        "https://github.com/nccgroup/tracy.git"
        "https://github.com/epinna/tplmap.git"
        "https://github.com/t3l3machus/toxssin.git"
        "https://github.com/sec-it/tls-map.git"
        "https://github.com/testssl/testssl.sh.git"
        "https://github.com/assetnote/surf.git"
        "https://github.com/PalindromeLabs/STEWS.git"
        "https://github.com/swisskyrepo/SSRFmap.git"
        "https://github.com/teknogeek/ssrf-sheriff.git"
        "https://github.com/bcoles/ssrf_proxy.git"
        "https://github.com/hannob/snallygaster.git"
        "https://github.com/postmodern/spidr.git"
        "https://github.com/danialhalo/SqliSniper.git"
        "https://github.com/the-robot/sqliv.git"
        "https://github.com/sqlmapproject/sqlmap.git"
        "https://github.com/ssllabs/ssllabs-scan/.git"
        "https://github.com/hannob/snallygaster.git"
        "https://github.com/defparam/smuggler.git"
        "https://github.com/RhinoSecurityLabs/SleuthQL.git"
        "https://github.com/BishopFox/sj.git"
        "https://github.com/shenril/Sitadel.git"
        "https://github.com/szski/shapeshifter.git"
        "https://github.com/doyensec/Session-Hijacking-Visual-Exploitation/.git"
        "https://github.com/OJ/gobuster.git"
        "https://github.com/internetwache/GitTools.git"
        "https://github.com/devanshbatham/FavFreak.git"
        "https://github.com/ffuf/ffuf.git"
        "https://github.com/Brum3ns/firefly.git"
        "https://github.com/pielco11/fav-up.git"
        "https://github.com/ssl/ezXSS.git"
        "https://github.com/RedSiege/EyeWitness.git"
        "https://github.com/whitel1st/docem.git"
        "https://github.com/wireghoul/dotdotpwn.git"
        "https://github.com/davtur19/DotGit.git"
        "https://github.com/SamJoan/droopescan.git"
        "https://github.com/immunIT/drupwn.git"
        "https://github.com/GoSecure/dtd-finder.git"
        "https://github.com/whitel1st/docem.git"
        "https://github.com/lmammino/distributed-jwt-cracker.git"
        "https://github.com/Ruulian/CSPass.git"
        "https://github.com/google/csp-evaluator.git"
        "https://github.com/nicholasaleks/CrackQL.git"
        "https://github.com/MindPointGroup/cloudfrunt.git"
        "https://github.com/Tuhinshubhra/CMSeeK.git"
        "https://github.com/Dionach/CMSmap.git"
        "https://github.com/nikitastupin/clairvoyance.git"
        "https://github.com/michelin/ChopChop.git"
        "https://github.com/TarlogicSecurity/Chankro.git"
        "https://github.com/deibit/cansina/.git"
        "https://github.com/s0md3v/Blazy.git"
        "https://github.com/mazen160/bfac.git"
        "https://github.com/beefproject/beef.git"
        "https://github.com/NickstaDB/BaRMIe.git"
        "https://github.com/blacklanternsecurity/badsecrets.git"
        "https://github.com/b374k/b374k.git"
        "https://github.com/m4ll0k/Atlas.git"
        "https://github.com/flipkart-incubator/astra.git"
        "https://github.com/AmyangXYZ/AssassinGo.git"
        "https://github.com/s0md3v/Arjun.git"
        "https://github.com/michenriksen/aquatone.git"
        "https://github.com/Fuzzapi/API-fuzzer.git"
        "https://github.com/evilsocket/altair.git"
        "https://github.com/RapidDNS/Afuzz.git"
        "https://github.com/zan8in/afrog.git"
        "https://github.com/WebBreacher/yoga.git"
        "https://github.com/0xsauby/yasuo.git"
        "https://github.com/aayla-secura/xxxpwn_smart.git"
        "https://github.com/feakk/xxxpwn.git"
        "https://github.com/luisfontes19/xxexploiter.git"
        "https://github.com/staaldraad/xxeserv.git"
        "https://github.com/enjoiz/XXEinjector.git"
        "https://github.com/s0md3v/XSStrike.git"
        "https://github.com/epsylon/xsser.git"
        "https://github.com/menkrep1337/XSSCon.git"
        "https://github.com/epsylon/xsser.git"
        "https://github.com/evilcos/xssor2.git"
        "https://github.com/evilcos/xssor.git"
        "https://github.com/mandatoryprogrammer/xsshunter-express.git"
        "https://github.com/0xInfection/XSRFProbe.git"
        "https://github.com/hahwul/XSpear.git"
        "https://github.com/RUB-NDS/xsinator.com.git"
        "https://github.com/RUB-NDS/xsinator.com.git"
        "https://github.com/chaitin/xray.git"
        "https://github.com/xnl-h4ck3r/xnLinkFinder.git"
        "https://github.com/ajinabraham/OWASP-Xenotix-XSS-Exploit-Framework.git"
        "https://github.com/orf/xcat.git"
        "https://github.com/Sh1Yo/x8.git"
        "https://github.com/RUB-NDS/WS-Attacker.git"
        "https://github.com/wpscanteam/wpscan.git"
        "https://github.com/ambionics/wrapwrap.git"
        "https://github.com/byt3bl33d3r/WitnessMe.git"
        "https://github.com/sensepost/wikto.git"
        "https://github.com/urbanadventurer/WhatWeb.git"
        "https://github.com/xmendez/wfuzz/.git"
        "https://github.com/epinna/weevely3.git"
        "https://github.com/webhooksite/webhook.site.git"
        "https://github.com/rverton/webanalyze.git"
        "https://github.com/khalilbijjou/WAFNinja.git"
        "https://github.com/andresriancho/w3af.git"
        "https://github.com/subgraph/Vega.git"
        "https://github.com/v3n0m-Scanner/V3n0M-Scanner.git"
        "https://github.com/whoot/Typo3Scan.git"
        "https://github.com/michael1026/trashcompactor.git"
        "https://github.com/nccgroup/tracy.git"
        "https://github.com/epinna/tplmap.git"
        "https://github.com/t3l3machus/toxssin.git"
        "https://github.com/sec-it/tls-map.git"
        "https://github.com/testssl/testssl.sh.git"
        "https://github.com/assetnote/surf.git"
        "https://github.com/PalindromeLabs/STEWS.git"
        "https://github.com/swisskyrepo/SSRFmap.git"
        "https://github.com/teknogeek/ssrf-sheriff.git"
        "https://github.com/bcoles/ssrf_proxy.git"
        "https://github.com/hannob/snallygaster.git"
        "https://github.com/postmodern/spidr.git"
        "https://github.com/danialhalo/SqliSniper.git"
        "https://github.com/the-robot/sqliv.git"
        "https://github.com/sqlmapproject/sqlmap.git"
        "https://github.com/ssllabs/ssllabs-scan/.git"
        "https://github.com/hannob/snallygaster.git"
        "https://github.com/defparam/smuggler.git"
        "https://github.com/RhinoSecurityLabs/SleuthQL.git"
        "https://github.com/BishopFox/sj.git"
        "https://github.com/shenril/Sitadel.git"
        "https://github.com/szski/shapeshifter.git"
        "https://github.com/doyensec/Session-Hijacking-Visual-Exploitation/.git"
        "https://github.com/OJ/gobuster.git"
        "https://github.com/internet"https://github.com/WebBreacher/yoga.git"
    "https://github.com/0xsauby/yasuo.git"
    "https://github.com/aayla-secura/xxxpwn_smart.git"
    "https://github.com/feakk/xxxpwn.git"
    "https://github.com/luisfontes19/xxexploiter.git"
    "https://github.com/staaldraad/xxeserv.git"
    "https://github.com/enjoiz/XXEinjector.git"
    "https://github.com/s0md3v/XSStrike.git"
    "https://github.com/epsylon/xsser.git"
    "https://github.com/menkrep1337/XSSCon.git"
    "https://github.com/epsylon/xsser.git"
    "https://github.com/evilcos/xssor2.git"
    "https://github.com/evilcos/xssor.git"
    "https://github.com/mandatoryprogrammer/xsshunter-express.git"
    "https://github.com/0xInfection/XSRFProbe.git"
    "https://github.com/hahwul/XSpear.git"
    "https://github.com/RUB-NDS/xsinator.com.git"
    "https://github.com/RUB-NDS/xsinator.com.git"
    "https://github.com/chaitin/xray.git"
    "https://github.com/xnl-h4ck3r/xnLinkFinder.git"
    "https://github.com/ajinabraham/OWASP-Xenotix-XSS-Exploit-Framework.git"
    "https://github.com/orf/xcat.git"
    "https://github.com/Sh1Yo/x8.git"
    "https://github.com/RUB-NDS/WS-Attacker.git"
    "https://github.com/wpscanteam/wpscan.git"
    "https://github.com/ambionics/wrapwrap.git"
    "https://github.com/byt3bl33d3r/WitnessMe.git"
    "https://github.com/sensepost/wikto.git"
    "https://github.com/urbanadventurer/WhatWeb.git"
    "https://github.com/xmendez/wfuzz/.git"
    "https://github.com/epinna/weevely3.git"
    "https://github.com/webhooksite/webhook.site.git"
    "https://github.com/rverton/webanalyze.git"
    "https://github.com/khalilbijjou/WAFNinja.git"
    "https://github.com/andresriancho/w3af.git"
    "https://github.com/subgraph/Vega.git"
    "https://github.com/v3n0m-Scanner/V3n0M-Scanner.git"
    "https://github.com/whoot/Typo3Scan.git"
    "https://github.com/michael1026/trashcompactor.git"
    "https://github.com/nccgroup/tracy.git"
    "https://github.com/epinna/tplmap.git"
    "https://github.com/t3l3machus/toxssin.git"
    "https://github.com/sec-it/tls-map.git"
    "https://github.com/testssl/testssl.sh.git"
    "https://github.com/assetnote/surf.git"
    "https://github.com/PalindromeLabs/STEWS.git"
    "https://github.com/swisskyrepo/SSRFmap.git"
    "https://github.com/teknogeek/ssrf-sheriff.git"
    "https://github.com/bcoles/ssrf_proxy.git"
    "https://github.com/hannob/snallygaster.git"
    "https://github.com/postmodern/spidr.git"
    "https://github.com/danialhalo/SqliSniper.git"
    "https://github.com/the-robot/sqliv.git"
    "https://github.com/sqlmapproject/sqlmap.git"
    "https://github.com/ssllabs/ssllabs-scan/.git"
    "https://github.com/hannob/snallygaster.git"
    "https://github.com/defparam/smuggler.git"
    "https://github.com/RhinoSecurityLabs/SleuthQL.git"
    "https://github.com/BishopFox/sj.git"
    "https://github.com/shenril/Sitadel.git"
    "https://github.com/szski/shapeshifter.git"
    "https://github.com/doyensec/Session-Hijacking-Visual-Exploitation/.git"
    "https://github.com/OJ/gobuster.git"
    "https://github.com/internetwache/GitTools.git"
    "https://github.com/devanshbatham/FavFreak.git"
    "https://github.com/ffuf/ffuf.git"
    "https://github.com/Brum3ns/firefly.git"
    "https://github.com/pielco11/fav-up.git"
    "https://github.com/ssl/ezXSS.git"
    "https://github.com/RedSiege/EyeWitness.git"
    "https://github.com/whitel1st/docem.git"
    "https://github.com/wireghoul/dotdotpwn.git"
    "https://github.com/davtur19/DotGit.git"
    "https://github.com/SamJoan/droopescan.git"
    "https://github.com/immunIT/drupwn.git"
    "https://github.com/GoSecure/dtd-finder.git"
    "https://github.com/whitel1st/docem.git"
    "https://github.com/lmammino/distributed-jwt-cracker.git"
    "https://github.com/Ruulian/CSPass.git"
    "https://github.com/google/csp-evaluator.git"
    "https://github.com/nicholasaleks/CrackQL.git"
    "https://github.com/MindPointGroup/cloudfrunt.git"
    "https://github.com/Tuhinshubhra/CMSeeK.git"
    "https://github.com/Dionach/CMSmap.git"
    "https://github.com/nikitastupin/clairvoyance.git"
    "https://github.com/michelin/ChopChop.git"
    "https://github.com/TarlogicSecurity/Chankro.git"
    "https://github.com/deibit/cansina/.git"
    "https://github.com/s0md3v/Blazy.git"
    "https://github.com/mazen160/bfac.git"
    "https://github.com/beefproject/beef.git"
    "https://github.com/NickstaDB/BaRMIe.git"
    "https://github.com/blacklanternsecurity/badsecrets.git"
    "https://github.com/b374k/b374k.git"
    "https://github.com/m4ll0k/Atlas.git"
    "https://github.com/flipkart-incubator/astra.git"
    "https://github.com/AmyangXYZ/AssassinGo.git"
    "https://github.com/s0md3v/Arjun.git"
    "https://github.com/michenriksen/aquatone.git"
    "https://github.com/Fuzzapi/API-fuzzer.git"
    "https://github.com/evilsocket/altair.git"
    "https://github.com/RapidDNS/Afuzz.git"
    "https://github.com/zan8in/afrog.git"
        "https://github.com/devanshbatham/FavFreak.git"
        "https://github.com/ffuf/ffuf.git"
        "https://github.com/Brum3ns/firefly.git"
        "https://github.com/pielco11/fav-up.git"
        "https://github.com/ssl/ezXSS.git"
        "https://github.com/RedSiege/EyeWitness.git"
        "https://github.com/whitel1st/docem.git"
        "https://github.com/wireghoul/dotdotpwn.git"
        "https://github.com/davtur19/DotGit.git"
        "https://github.com/SamJoan/droopescan.git"
        "https://github.com/immunIT/drupwn.git"
        "https://github.com/GoSecure/dtd-finder.git"
        "https://github.com/whitel1st/docem.git"
        "https://github.com/lmammino/distributed-jwt-cracker.git"
        "https://github.com/Ruulian/CSPass.git"
        "https://github.com/google/csp-evaluator.git"
        "https://github.com/nicholasaleks/CrackQL.git"
        "https://github.com/MindPointGroup/cloudfrunt.git"
        "https://github.com/Tuhinshubhra/CMSeeK.git"
        "https://github.com/Dionach/CMSmap.git"
        "https://github.com/nikitastupin/clairvoyance.git"
        "https://github.com/michelin/ChopChop.git"
        "https://github.com/TarlogicSecurity/Chankro.git"
        "https://github.com/deibit/cansina/.git"
        "https://github.com/s0md3v/Blazy.git"
        "https://github.com/mazen160/bfac.git"
        "https://github.com/beefproject/beef.git"
        "https://github.com/NickstaDB/BaRMIe.git"
        "https://github.com/blacklanternsecurity/badsecrets.git"
        "https://github.com/b374k/b374k.git"
        "https://github.com/m4ll0k/Atlas.git"
        "https://github.com/flipkart-incubator/astra.git"
        "https://github.com/AmyangXYZ/AssassinGo.git"
        "https://github.com/s0md3v/Arjun.git"
        "https://github.com/michenriksen/aquatone.git"
        "https://github.com/Fuzzapi/API-fuzzer.git"
        "https://github.com/evilsocket/altair.git"
        "https://github.com/RapidDNS/Afuzz.git"
        "https://github.com/zan8in/afrog.git"

    )

    # We sanitize the argument in case the user surrounds it with quotes.
    # If the user typed something like ""booty"" (with double quotes), this will remove them.
    local raw_dir="$1"
    local sanitized_dir
    sanitized_dir="$(sed -E 's/^\"+|\"+$//g' <<< "$raw_dir")"

    # If no argument or sanitized argument is empty, default to cloned_repos.
    local output_dir="${sanitized_dir:-cloned_repos}"

    mkdir -p "$output_dir"

    echo "[INFO]: Starting the cloning process."
    for repo in "${repos[@]}"; do
        local repo_name
        repo_name="$(basename "$repo" .git)"

        echo "[INFO]: Processing repository: $repo_name"

        # -----------------------------
        # CLONE OR PULL THE REPOSITORY
        # -----------------------------
        if [ ! -d "$output_dir/$repo_name" ]; then
            echo "[INFO]: Cloning $repo into $output_dir/$repo_name..."
            if ! git clone "$repo" "$output_dir/$repo_name"; then
                log_error "Failed to clone $repo. Skipping this repository..."
                continue
            fi
            echo "[INFO]: Successfully cloned $repo_name."
        else
            echo "[INFO]: $repo_name already exists. Pulling latest changes..."
            if ! (cd "$output_dir/$repo_name" && git pull); then
                log_error "Failed to pull changes for $repo_name. Skipping further steps for this repo..."
                continue
            fi
            echo "[INFO]: Successfully pulled latest changes for $repo_name."
        fi

        # ------------------------------------
        # CHECK FOR INSTALL SCRIPT & EXECUTE
        # ------------------------------------
        if has_install_script "$output_dir/$repo_name"; then
            echo "[INFO]: Found an installation script in $repo_name. Marking as executable and running..."
            chmod +x "$output_dir/$repo_name"/*install*.sh
            if ! (cd "$output_dir/$repo_name" && bash ./*install*.sh); then
                echo "[WARNING]: Could not run the installation script for $repo_name."
                # continue  # If you want to skip to the next repo on error, uncomment this.
            fi
        else
            echo "[INFO]: No installation script found for $repo_name."
            # ----------------------------------------------------------
            # CHECK IF IT IS PYTHON-BASED; IF SO, CREATE VENV AND INSTALL
            # ----------------------------------------------------------
            if is_python_repo "$output_dir/$repo_name"; then
                echo "[INFO]: $repo_name appears to be a Python repo. Creating virtual environment and installing."
                if ! cd "$output_dir/$repo_name"; then
                    log_error "Could not enter directory $output_dir/$repo_name. Skipping..."
                    continue
                fi

                python3 -m venv venv
                source venv/bin/activate

                if [[ -f "requirements.txt" ]]; then
                    echo "[INFO]: Installing from requirements.txt..."
                    pip install --upgrade pip
                    if ! pip install -r requirements.txt; then
                        log_error "Failed to install Python dependencies for $repo_name."
                        # continue  # Uncomment if you want to skip next steps for this repo.
                    fi
                elif [[ -f "setup.py" ]]; then
                    echo "[INFO]: Running setup.py install..."
                    pip install --upgrade pip
                    if ! python setup.py install; then
                        log_error "Failed to run setup.py install for $repo_name."
                        # continue
                    fi
                fi

                deactivate
                cd - >/dev/null || true

            else
                echo "[INFO]: $repo_name doesn't appear to be Python-based. Skipping venv setup."
            fi
        fi

        echo "[INFO]: Finished processing $repo_name."
        echo "--------------------------------------------------"
    done

    echo "[INFO]: All repositories have been processed."
    echo "[INFO]: Please review and understand the purpose of each repository before running or installing its contents."
}

# Example usage:
#   ./install.sh [output_directory]
# If no output_directory is provided, it defaults to "cloned_repos".

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    install_tools "$1"
fi

Install_security_and_network_tools() {
    echo "[+] Installing essential tools for network administration and security..."
    local tools=(
        net-tools tcpdump traceroute mtr iperf3 dnsutils whois tshark arp-scan ettercap-common dsniff
        metasploit-framework wireshark nmap aircrack-ng john hashcat zaproxy sqlmap hydra proxychains
        gobuster dirb checksec nikto wpscan macchanger responder bloodhound impacket-scripts
        crackmapexec seclists nishang powersploit enum4linux recon-ng tor xplico apache2 openvas
        netcat
    )

    # Example: apt-get install logic here, with error checks if you wish.   
    # ...
}
        "https://github.com/nicholasaleks/CrackQL.git"
        "https://github.com/MindPointGroup/cloudfrunt.git"
        "https://github.com/Tuhinshubhra/CMSeeK.git"
        "https://github.com/Dionach/CMSmap.git"
        "https://github.com/nikitastupin/clairvoyance.git"
        "https://github.com/michelin/ChopChop.git"
        "https://github.com/TarlogicSecurity/Chankro.git"
        "https://github.com/deibit/cansina/.git"
        "https://github.com/s0md3v/Blazy.git"
        "https://github.com/mazen160/bfac.git"
        "https://github.com/beefproject/beef.git"
        "https://github.com/NickstaDB/BaRMIe.git"
        "https://github.com/blacklanternsecurity/badsecrets.git"
        "https://github.com/b374k/b374k.git"
        "https://github.com/m4ll0k/Atlas.git"
        "https://github.com/flipkart-incubator/astra.git"
        "https://github.com/AmyangXYZ/AssassinGo.git"
        "https://github.com/s0md3v/Arjun.git"
        "https://github.com/michenriksen/aquatone.git"
        "https://github.com/Fuzzapi/API-fuzzer.git"
        "https://github.com/evilsocket/altair.git"
        "https://github.com/RapidDNS/Afuzz.git"
        "https://github.com/zan8in/afrog.git"
        "https://github.com/WebBreacher/yoga.git"
        "https://github.com/0xsauby/yasuo.git"
        "https://github.com/aayla-secura/xxxpwn_smart.git"
        "https://github.com/feakk/xxxpwn.git"
        "https://github.com/luisfontes19/xxexploiter.git"
        "https://github.com/staaldraad/xxeserv.git"
        "https://github.com/enjoiz/XXEinjector.git"
        "https://github.com/s0md3v/XSStrike.git"
        "https://github.com/epsylon/xsser.git"
        "https://github.com/menkrep1337/XSSCon.git"
        "https://github.com/epsylon/xsser.git"
        "https://github.com/evilcos/xssor2.git"
        "https://github.com/evilcos/xssor.git"
        "https://github.com/mandatoryprogrammer/xsshunter-express.git"
        "https://github.com/0xInfection/XSRFProbe.git"
        "https://github.com/hahwul/XSpear.git"
        "https://github.com/RUB-NDS/xsinator.com.git"
        "https://github.com/RUB-NDS/xsinator.com.git"
        "https://github.com/chaitin/xray.git"
        "https://github.com/xnl-h4ck3r/xnLinkFinder.git"
        "https://github.com/ajinabraham/OWASP-Xenotix-XSS-Exploit-Framework.git"
        "https://github.com/orf/xcat.git"
        "https://github.com/Sh1Yo/x8.git"
        "https://github.com/RUB-NDS/WS-Attacker.git"
        "https://github.com/wpscanteam/wpscan.git"
        "https://github.com/ambionics/wrapwrap.git"
        "https://github.com/byt3bl33d3r/WitnessMe.git"
        "https://github.com/sensepost/wikto.git"
        "https://github.com/urbanadventurer/WhatWeb.git"
        "https://github.com/xmendez/wfuzz/.git"
        "https://github.com/epinna/weevely3.git"
        "https://github.com/webhooksite/webhook.site.git"
        "https://github.com/rverton/webanalyze.git"
        "https://github.com/khalilbijjou/WAFNinja.git"
        "https://github.com/andresriancho/w3af.git"
        "https://github.com/subgraph/Vega.git"
        "https://github.com/v3n0m-Scanner/V3n0M-Scanner.git"
        "https://github.com/whoot/Typo3Scan.git"
        "https://github.com/michael1026/trashcompactor.git"
        "https://github.com/nccgroup/tracy.git"
        "https://github.com/epinna/tplmap.git"
        "https://github.com/t3l3machus/toxssin.git"
        "https://github.com/sec-it/tls-map.git"
        "https://github.com/testssl/testssl.sh.git"
        "https://github.com/assetnote/surf.git"
        "https://github.com/PalindromeLabs/STEWS.git"
        "https://github.com/swisskyrepo/SSRFmap.git"
        "https://github.com/teknogeek/ssrf-sheriff.git"
        "https://github.com/bcoles/ssrf_proxy.git"
        "https://github.com/hannob/snallygaster.git"
        "https://github.com/postmodern/spidr.git"
        "https://github.com/danialhalo/SqliSniper.git"
        "https://github.com/the-robot/sqliv.git"
        "https://github.com/sqlmapproject/sqlmap.git"
        "https://github.com/ssllabs/ssllabs-scan/.git"
        "https://github.com/hannob/snallygaster.git"
        "https://github.com/defparam/smuggler.git"
        "https://github.com/RhinoSecurityLabs/SleuthQL.git"
        "https://github.com/BishopFox/sj.git"
        "https://github.com/shenril/Sitadel.git"
        "https://github.com/szski/shapeshifter.git"
        "https://github.com/doyensec/Session-Hijacking-Visual-Exploitation/.git"
        "https://github.com/OJ/gobuster.git"
        "https://github.com/internet"https://github.com/WebBreacher/yoga.git"
    "https://github.com/0xsauby/yasuo.git"
    "https://github.com/aayla-secura/xxxpwn_smart.git"
    "https://github.com/feakk/xxxpwn.git"
    "https://github.com/luisfontes19/xxexploiter.git"
    "https://github.com/staaldraad/xxeserv.git"
    "https://github.com/enjoiz/XXEinjector.git"
    "https://github.com/s0md3v/XSStrike.git"
    "https://github.com/epsylon/xsser.git"
    "https://github.com/menkrep1337/XSSCon.git"
    "https://github.com/epsylon/xsser.git"
    "https://github.com/evilcos/xssor2.git"
    "https://github.com/evilcos/xssor.git"
    "https://github.com/mandatoryprogrammer/xsshunter-express.git"
    "https://github.com/0xInfection/XSRFProbe.git"
    "https://github.com/hahwul/XSpear.git"
    "https://github.com/RUB-NDS/xsinator.com.git"
    "https://github.com/RUB-NDS/xsinator.com.git"
    "https://github.com/chaitin/xray.git"
    "https://github.com/xnl-h4ck3r/xnLinkFinder.git"
    "https://github.com/ajinabraham/OWASP-Xenotix-XSS-Exploit-Framework.git"
    "https://github.com/orf/xcat.git"
    "https://github.com/Sh1Yo/x8.git"
    "https://github.com/RUB-NDS/WS-Attacker.git"
    "https://github.com/wpscanteam/wpscan.git"
    "https://github.com/ambionics/wrapwrap.git"
    "https://github.com/byt3bl33d3r/WitnessMe.git"
    "https://github.com/sensepost/wikto.git"
    "https://github.com/urbanadventurer/WhatWeb.git"
    "https://github.com/xmendez/wfuzz/.git"
    "https://github.com/epinna/weevely3.git"
    "https://github.com/webhooksite/webhook.site.git"
    "https://github.com/rverton/webanalyze.git"
    "https://github.com/khalilbijjou/WAFNinja.git"
    "https://github.com/andresriancho/w3af.git"
    "https://github.com/subgraph/Vega.git"
    "https://github.com/v3n0m-Scanner/V3n0M-Scanner.git"
    "https://github.com/whoot/Typo3Scan.git"
    "https://github.com/michael1026/trashcompactor.git"
    "https://github.com/nccgroup/tracy.git"
    "https://github.com/epinna/tplmap.git"
    "https://github.com/t3l3machus/toxssin.git"
    "https://github.com/sec-it/tls-map.git"
    "https://github.com/testssl/testssl.sh.git"
    "https://github.com/assetnote/surf.git"
    "https://github.com/PalindromeLabs/STEWS.git"
    "https://github.com/swisskyrepo/SSRFmap.git"
    "https://github.com/teknogeek/ssrf-sheriff.git"
    "https://github.com/bcoles/ssrf_proxy.git"
    "https://github.com/hannob/snallygaster.git"
    "https://github.com/postmodern/spidr.git"
    "https://github.com/danialhalo/SqliSniper.git"
    "https://github.com/the-robot/sqliv.git"
    "https://github.com/sqlmapproject/sqlmap.git"
    "https://github.com/ssllabs/ssllabs-scan/.git"
    "https://github.com/hannob/snallygaster.git"
    "https://github.com/defparam/smuggler.git"
    "https://github.com/RhinoSecurityLabs/SleuthQL.git"
    "https://github.com/BishopFox/sj.git"
    "https://github.com/shenril/Sitadel.git"
    "https://github.com/szski/shapeshifter.git"
    "https://github.com/doyensec/Session-Hijacking-Visual-Exploitation/.git"
    "https://github.com/OJ/gobuster.git"
    "https://github.com/internetwache/GitTools.git"
    "https://github.com/devanshbatham/FavFreak.git"
    "https://github.com/ffuf/ffuf.git"
    "https://github.com/Brum3ns/firefly.git"
    "https://github.com/pielco11/fav-up.git"
    "https://github.com/ssl/ezXSS.git"
    "https://github.com/RedSiege/EyeWitness.git"
    "https://github.com/whitel1st/docem.git"
    "https://github.com/wireghoul/dotdotpwn.git"
    "https://github.com/davtur19/DotGit.git"
    "https://github.com/SamJoan/droopescan.git"
    "https://github.com/immunIT/drupwn.git"
    "https://github.com/GoSecure/dtd-finder.git"
    "https://github.com/whitel1st/docem.git"
    "https://github.com/lmammino/distributed-jwt-cracker.git"
    "https://github.com/Ruulian/CSPass.git"
    "https://github.com/google/csp-evaluator.git"
    "https://github.com/nicholasaleks/CrackQL.git"
    "https://github.com/MindPointGroup/cloudfrunt.git"
    "https://github.com/Tuhinshubhra/CMSeeK.git"
    "https://github.com/Dionach/CMSmap.git"
    "https://github.com/nikitastupin/clairvoyance.git"
    "https://github.com/michelin/ChopChop.git"
    "https://github.com/TarlogicSecurity/Chankro.git"
    "https://github.com/deibit/cansina/.git"
    "https://github.com/s0md3v/Blazy.git"
    "https://github.com/mazen160/bfac.git"
    "https://github.com/beefproject/beef.git"
    "https://github.com/NickstaDB/BaRMIe.git"
    "https://github.com/blacklanternsecurity/badsecrets.git"
    "https://github.com/b374k/b374k.git"
    "https://github.com/m4ll0k/Atlas.git"
    "https://github.com/flipkart-incubator/astra.git"
    "https://github.com/AmyangXYZ/AssassinGo.git"
    "https://github.com/s0md3v/Arjun.git"
    "https://github.com/michenriksen/aquatone.git"
    "https://github.com/Fuzzapi/API-fuzzer.git"
    "https://github.com/evilsocket/altair.git"
    "https://github.com/RapidDNS/Afuzz.git"
    "https://github.com/zan8in/afrog.git"
        "https://github.com/devanshbatham/FavFreak.git"
        "https://github.com/ffuf/ffuf.git"
        "https://github.com/Brum3ns/firefly.git"
        "https://github.com/pielco11/fav-up.git"
        "https://github.com/ssl/ezXSS.git"
        "https://github.com/RedSiege/EyeWitness.git"
        "https://github.com/whitel1st/docem.git"
        "https://github.com/wireghoul/dotdotpwn.git"
        "https://github.com/davtur19/DotGit.git"
        "https://github.com/SamJoan/droopescan.git"
        "https://github.com/immunIT/drupwn.git"
        "https://github.com/GoSecure/dtd-finder.git"
        "https://github.com/whitel1st/docem.git"
        "https://github.com/lmammino/distributed-jwt-cracker.git"
        "https://github.com/Ruulian/CSPass.git"
        "https://github.com/google/csp-evaluator.git"
        "https://github.com/nicholasaleks/CrackQL.git"
        "https://github.com/MindPointGroup/cloudfrunt.git"
        "https://github.com/Tuhinshubhra/CMSeeK.git"
        "https://github.com/Dionach/CMSmap.git"
        "https://github.com/nikitastupin/clairvoyance.git"
        "https://github.com/michelin/ChopChop.git"
        "https://github.com/TarlogicSecurity/Chankro.git"
        "https://github.com/deibit/cansina/.git"
        "https://github.com/s0md3v/Blazy.git"
        "https://github.com/mazen160/bfac.git"
        "https://github.com/beefproject/beef.git"
        "https://github.com/NickstaDB/BaRMIe.git"
        "https://github.com/blacklanternsecurity/badsecrets.git"
        "https://github.com/b374k/b374k.git"
        "https://github.com/m4ll0k/Atlas.git"
        "https://github.com/flipkart-incubator/astra.git"
        "https://github.com/AmyangXYZ/AssassinGo.git"
        "https://github.com/s0md3v/Arjun.git"
        "https://github.com/michenriksen/aquatone.git"
        "https://github.com/Fuzzapi/API-fuzzer.git"
        "https://github.com/evilsocket/altair.git"
        "https://github.com/RapidDNS/Afuzz.git"
        "https://github.com/zan8in/afrog.git"

    )

    # We sanitize the argument in case the user surrounds it with quotes.
    # If the user typed something like ""booty"" (with double quotes), this will remove them.
    local raw_dir="$1"
    local sanitized_dir
    sanitized_dir="$(sed -E 's/^\"+|\"+$//g' <<< "$raw_dir")"

    # If no argument or sanitized argument is empty, default to cloned_repos.
    local output_dir="${sanitized_dir:-cloned_repos}"

    mkdir -p "$output_dir"

    echo "[INFO]: Starting the cloning process."
    for repo in "${repos[@]}"; do
        local repo_name
        repo_name="$(basename "$repo" .git)"

        echo "[INFO]: Processing repository: $repo_name"

        # -----------------------------
        # CLONE OR PULL THE REPOSITORY
        # -----------------------------
        if [ ! -d "$output_dir/$repo_name" ]; then
            echo "[INFO]: Cloning $repo into $output_dir/$repo_name..."
            if ! git clone "$repo" "$output_dir/$repo_name"; then
                log_error "Failed to clone $repo. Skipping this repository..."
                continue
            fi
            echo "[INFO]: Successfully cloned $repo_name."
        else
            echo "[INFO]: $repo_name already exists. Pulling latest changes..."
            if ! (cd "$output_dir/$repo_name" && git pull); then
                log_error "Failed to pull changes for $repo_name. Skipping further steps for this repo..."
                continue
            fi
            echo "[INFO]: Successfully pulled latest changes for $repo_name."
        fi

        # ------------------------------------
        # CHECK FOR INSTALL SCRIPT & EXECUTE
        # ------------------------------------
        if has_install_script "$output_dir/$repo_name"; then
            echo "[INFO]: Found an installation script in $repo_name. Marking as executable and running..."
            chmod +x "$output_dir/$repo_name"/*install*.sh
            if ! (cd "$output_dir/$repo_name" && bash ./*install*.sh); then
                echo "[WARNING]: Could not run the installation script for $repo_name."
                # continue  # If you want to skip to the next repo on error, uncomment this.
            fi
        else
            echo "[INFO]: No installation script found for $repo_name."
            # ----------------------------------------------------------
            # CHECK IF IT IS PYTHON-BASED; IF SO, CREATE VENV AND INSTALL
            # ----------------------------------------------------------
            if is_python_repo "$output_dir/$repo_name"; then
                echo "[INFO]: $repo_name appears to be a Python repo. Creating virtual environment and installing."
                if ! cd "$output_dir/$repo_name"; then
                    log_error "Could not enter directory $output_dir/$repo_name. Skipping..."
                    continue
                fi

                python3 -m venv venv
                source venv/bin/activate

                if [[ -f "requirements.txt" ]]; then
                    echo "[INFO]: Installing from requirements.txt..."
                    pip install --upgrade pip
                    if ! pip install -r requirements.txt; then
                        log_error "Failed to install Python dependencies for $repo_name."
                        # continue  # Uncomment if you want to skip next steps for this repo.
                    fi
                elif [[ -f "setup.py" ]]; then
                    echo "[INFO]: Running setup.py install..."
                    pip install --upgrade pip
                    if ! python setup.py install; then
                        log_error "Failed to run setup.py install for $repo_name."
                        # continue
                    fi
                fi

                deactivate
                cd - >/dev/null || true

            else
                echo "[INFO]: $repo_name doesn't appear to be Python-based. Skipping venv setup."
            fi
        fi

        echo "[INFO]: Finished processing $repo_name."
        echo "--------------------------------------------------"
    done

    echo "[INFO]: All repositories have been processed."
    echo "[INFO]: Please review and understand the purpose of each repository before running or installing its contents."
}

# Example usage:
#   ./install.sh [output_directory]
# If no output_directory is provided, it defaults to "cloned_repos".

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    install_tools "$1"
fi

Install_security_and_network_tools() {
    echo "[+] Installing essential tools for network administration and security..."
    local tools=(
        net-tools tcpdump traceroute mtr iperf3 dnsutils whois tshark arp-scan ettercap-common dsniff
        metasploit-framework wireshark nmap aircrack-ng john hashcat zaproxy sqlmap hydra proxychains
        gobuster dirb checksec nikto wpscan macchanger responder bloodhound impacket-scripts
        crackmapexec seclists nishang powersploit enum4linux recon-ng tor xplico apache2 openvas
        netcat
    )

    # Example: apt-get install logic here, with error checks if you wish.   
    # ...
}
        "https://github.com/mandatoryprogrammer/xsshunter-express.git"
        "https://github.com/0xInfection/XSRFProbe.git"
        "https://github.com/hahwul/XSpear.git"
        "https://github.com/RUB-NDS/xsinator.com.git"
        "https://github.com/RUB-NDS/xsinator.com.git"
        "https://github.com/chaitin/xray.git"
        "https://github.com/xnl-h4ck3r/xnLinkFinder.git"
        "https://github.com/ajinabraham/OWASP-Xenotix-XSS-Exploit-Framework.git"
        "https://github.com/orf/xcat.git"
        "https://github.com/Sh1Yo/x8.git"
        "https://github.com/RUB-NDS/WS-Attacker.git"
        "https://github.com/wpscanteam/wpscan.git"
        "https://github.com/ambionics/wrapwrap.git"
        "https://github.com/byt3bl33d3r/WitnessMe.git"
        "https://github.com/sensepost/wikto.git"
        "https://github.com/urbanadventurer/WhatWeb.git"
        "https://github.com/xmendez/wfuzz/.git"
        "https://github.com/epinna/weevely3.git"
        "https://github.com/webhooksite/webhook.site.git"
        "https://github.com/rverton/webanalyze.git"
        "https://github.com/khalilbijjou/WAFNinja.git"
        "https://github.com/andresriancho/w3af.git"
        "https://github.com/subgraph/Vega.git"
        "https://github.com/v3n0m-Scanner/V3n0M-Scanner.git"
        "https://github.com/whoot/Typo3Scan.git"
        "https://github.com/michael1026/trashcompactor.git"
        "https://github.com/nccgroup/tracy.git"
        "https://github.com/epinna/tplmap.git"
        "https://github.com/t3l3machus/toxssin.git"
        "https://github.com/sec-it/tls-map.git"
        "https://github.com/testssl/testssl.sh.git"
        "https://github.com/assetnote/surf.git"
        "https://github.com/PalindromeLabs/STEWS.git"
        "https://github.com/swisskyrepo/SSRFmap.git"
        "https://github.com/teknogeek/ssrf-sheriff.git"
        "https://github.com/bcoles/ssrf_proxy.git"
        "https://github.com/hannob/snallygaster.git"
        "https://github.com/postmodern/spidr.git"
        "https://github.com/danialhalo/SqliSniper.git"
        "https://github.com/the-robot/sqliv.git"
        "https://github.com/sqlmapproject/sqlmap.git"
        "https://github.com/ssllabs/ssllabs-scan/.git"
        "https://github.com/hannob/snallygaster.git"
        "https://github.com/defparam/smuggler.git"
        "https://github.com/RhinoSecurityLabs/SleuthQL.git"
        "https://github.com/BishopFox/sj.git"
        "https://github.com/shenril/Sitadel.git"
        "https://github.com/szski/shapeshifter.git"
        "https://github.com/doyensec/Session-Hijacking-Visual-Exploitation/.git"
        "https://github.com/OJ/gobuster.git"
        "https://github.com/internetwache/GitTools.git"
        "https://github.com/devanshbatham/FavFreak.git"
        "https://github.com/ffuf/ffuf.git"
        "https://github.com/Brum3ns/firefly.git"
        "https://github.com/pielco11/fav-up.git"
        "https://github.com/ssl/ezXSS.git"
        "https://github.com/RedSiege/EyeWitness.git"
        "https://github.com/whitel1st/docem.git"
        "https://github.com/wireghoul/dotdotpwn.git"
        "https://github.com/davtur19/DotGit.git"
        "https://github.com/SamJoan/droopescan.git"
        "https://github.com/immunIT/drupwn.git"
        "https://github.com/GoSecure/dtd-finder.git"
        "https://github.com/whitel1st/docem.git"
        "https://github.com/lmammino/distributed-jwt-cracker.git"
        "https://github.com/Ruulian/CSPass.git"
        "https://github.com/google/csp-evaluator.git"
        "https://github.com/nicholasaleks/CrackQL.git"
        "https://github.com/MindPointGroup/cloudfrunt.git"
        "https://github.com/Tuhinshubhra/CMSeeK.git"
        "https://github.com/Dionach/CMSmap.git"
        "https://github.com/nikitastupin/clairvoyance.git"
        "https://github.com/michelin/ChopChop.git"
        "https://github.com/TarlogicSecurity/Chankro.git"
        "https://github.com/deibit/cansina/.git"
        "https://github.com/s0md3v/Blazy.git"
        "https://github.com/mazen160/bfac.git"
        "https://github.com/beefproject/beef.git"
        "https://github.com/NickstaDB/BaRMIe.git"
        "https://github.com/blacklanternsecurity/badsecrets.git"
        "https://github.com/b374k/b374k.git"
        "https://github.com/m4ll0k/Atlas.git"
        "https://github.com/flipkart-incubator/astra.git"
        "https://github.com/AmyangXYZ/AssassinGo.git"
        "https://github.com/s0md3v/Arjun.git"
        "https://github.com/michenriksen/aquatone.git"
        "https://github.com/Fuzzapi/API-fuzzer.git"
        "https://github.com/evilsocket/altair.git"
        "https://github.com/RapidDNS/Afuzz.git"
        "https://github.com/zan8in/afrog.git"
        "https://github.com/WebBreacher/yoga.git"
        "https://github.com/0xsauby/yasuo.git"
        "https://github.com/aayla-secura/xxxpwn_smart.git"
        "https://github.com/feakk/xxxpwn.git"
        "https://github.com/luisfontes19/xxexploiter.git"
        "https://github.com/staaldraad/xxeserv.git"
        "https://github.com/enjoiz/XXEinjector.git"
        "https://github.com/s0md3v/XSStrike.git"
        "https://github.com/epsylon/xsser.git"
        "https://github.com/menkrep1337/XSSCon.git"
        "https://github.com/epsylon/xsser.git"
        "https://github.com/evilcos/xssor2.git"
        "https://github.com/evilcos/xssor.git"
        "https://github.com/mandatoryprogrammer/xsshunter-express.git"
        "https://github.com/0xInfection/XSRFProbe.git"
        "https://github.com/hahwul/XSpear.git"
        "https://github.com/RUB-NDS/xsinator.com.git"
        "https://github.com/RUB-NDS/xsinator.com.git"
        "https://github.com/chaitin/xray.git"
        "https://github.com/xnl-h4ck3r/xnLinkFinder.git"
        "https://github.com/ajinabraham/OWASP-Xenotix-XSS-Exploit-Framework.git"
        "https://github.com/orf/xcat.git"
        "https://github.com/Sh1Yo/x8.git"
        "https://github.com/RUB-NDS/WS-Attacker.git"
        "https://github.com/wpscanteam/wpscan.git"
        "https://github.com/ambionics/wrapwrap.git"
        "https://github.com/byt3bl33d3r/WitnessMe.git"
        "https://github.com/sensepost/wikto.git"
        "https://github.com/urbanadventurer/WhatWeb.git"
        "https://github.com/xmendez/wfuzz/.git"
        "https://github.com/epinna/weevely3.git"
        "https://github.com/webhooksite/webhook.site.git"
        "https://github.com/rverton/webanalyze.git"
        "https://github.com/khalilbijjou/WAFNinja.git"
        "https://github.com/andresriancho/w3af.git"
        "https://github.com/subgraph/Vega.git"
        "https://github.com/v3n0m-Scanner/V3n0M-Scanner.git"
        "https://github.com/whoot/Typo3Scan.git"
        "https://github.com/michael1026/trashcompactor.git"
        "https://github.com/nccgroup/tracy.git"
        "https://github.com/epinna/tplmap.git"
        "https://github.com/t3l3machus/toxssin.git"
        "https://github.com/sec-it/tls-map.git"
        "https://github.com/testssl/testssl.sh.git"
        "https://github.com/assetnote/surf.git"
        "https://github.com/PalindromeLabs/STEWS.git"
        "https://github.com/swisskyrepo/SSRFmap.git"
        "https://github.com/teknogeek/ssrf-sheriff.git"
        "https://github.com/bcoles/ssrf_proxy.git"
        "https://github.com/hannob/snallygaster.git"
        "https://github.com/postmodern/spidr.git"
        "https://github.com/danialhalo/SqliSniper.git"
        "https://github.com/the-robot/sqliv.git"
        "https://github.com/sqlmapproject/sqlmap.git"
        "https://github.com/ssllabs/ssllabs-scan/.git"
        "https://github.com/hannob/snallygaster.git"
        "https://github.com/defparam/smuggler.git"
        "https://github.com/RhinoSecurityLabs/SleuthQL.git"
        "https://github.com/BishopFox/sj.git"
        "https://github.com/shenril/Sitadel.git"
        "https://github.com/szski/shapeshifter.git"
        "https://github.com/doyensec/Session-Hijacking-Visual-Exploitation/.git"
        "https://github.com/OJ/gobuster.git"
        "https://github.com/internet"https://github.com/WebBreacher/yoga.git"
    "https://github.com/0xsauby/yasuo.git"
    "https://github.com/aayla-secura/xxxpwn_smart.git"
    "https://github.com/feakk/xxxpwn.git"
    "https://github.com/luisfontes19/xxexploiter.git"
    "https://github.com/staaldraad/xxeserv.git"
    "https://github.com/enjoiz/XXEinjector.git"
    "https://github.com/s0md3v/XSStrike.git"
    "https://github.com/epsylon/xsser.git"
    "https://github.com/menkrep1337/XSSCon.git"
    "https://github.com/epsylon/xsser.git"
    "https://github.com/evilcos/xssor2.git"
    "https://github.com/evilcos/xssor.git"
    "https://github.com/mandatoryprogrammer/xsshunter-express.git"
    "https://github.com/0xInfection/XSRFProbe.git"
    "https://github.com/hahwul/XSpear.git"
    "https://github.com/RUB-NDS/xsinator.com.git"
    "https://github.com/RUB-NDS/xsinator.com.git"
    "https://github.com/chaitin/xray.git"
    "https://github.com/xnl-h4ck3r/xnLinkFinder.git"
    "https://github.com/ajinabraham/OWASP-Xenotix-XSS-Exploit-Framework.git"
    "https://github.com/orf/xcat.git"
    "https://github.com/Sh1Yo/x8.git"
    "https://github.com/RUB-NDS/WS-Attacker.git"
    "https://github.com/wpscanteam/wpscan.git"
    "https://github.com/ambionics/wrapwrap.git"
    "https://github.com/byt3bl33d3r/WitnessMe.git"
    "https://github.com/sensepost/wikto.git"
    "https://github.com/urbanadventurer/WhatWeb.git"
    "https://github.com/xmendez/wfuzz/.git"
    "https://github.com/epinna/weevely3.git"
    "https://github.com/webhooksite/webhook.site.git"
    "https://github.com/rverton/webanalyze.git"
    "https://github.com/khalilbijjou/WAFNinja.git"
    "https://github.com/andresriancho/w3af.git"
    "https://github.com/subgraph/Vega.git"
    "https://github.com/v3n0m-Scanner/V3n0M-Scanner.git"
    "https://github.com/whoot/Typo3Scan.git"
    "https://github.com/michael1026/trashcompactor.git"
    "https://github.com/nccgroup/tracy.git"
    "https://github.com/epinna/tplmap.git"
    "https://github.com/t3l3machus/toxssin.git"
    "https://github.com/sec-it/tls-map.git"
    "https://github.com/testssl/testssl.sh.git"
    "https://github.com/assetnote/surf.git"
    "https://github.com/PalindromeLabs/STEWS.git"
    "https://github.com/swisskyrepo/SSRFmap.git"
    "https://github.com/teknogeek/ssrf-sheriff.git"
    "https://github.com/bcoles/ssrf_proxy.git"
    "https://github.com/hannob/snallygaster.git"
    "https://github.com/postmodern/spidr.git"
    "https://github.com/danialhalo/SqliSniper.git"
    "https://github.com/the-robot/sqliv.git"
    "https://github.com/sqlmapproject/sqlmap.git"
    "https://github.com/ssllabs/ssllabs-scan/.git"
    "https://github.com/hannob/snallygaster.git"
    "https://github.com/defparam/smuggler.git"
    "https://github.com/RhinoSecurityLabs/SleuthQL.git"
    "https://github.com/BishopFox/sj.git"
    "https://github.com/shenril/Sitadel.git"
    "https://github.com/szski/shapeshifter.git"
    "https://github.com/doyensec/Session-Hijacking-Visual-Exploitation/.git"
    "https://github.com/OJ/gobuster.git"
    "https://github.com/internetwache/GitTools.git"
    "https://github.com/devanshbatham/FavFreak.git"
    "https://github.com/ffuf/ffuf.git"
    "https://github.com/Brum3ns/firefly.git"
    "https://github.com/pielco11/fav-up.git"
    "https://github.com/ssl/ezXSS.git"
    "https://github.com/RedSiege/EyeWitness.git"
    "https://github.com/whitel1st/docem.git"
    "https://github.com/wireghoul/dotdotpwn.git"
    "https://github.com/davtur19/DotGit.git"
    "https://github.com/SamJoan/droopescan.git"
    "https://github.com/immunIT/drupwn.git"
    "https://github.com/GoSecure/dtd-finder.git"
    "https://github.com/whitel1st/docem.git"
    "https://github.com/lmammino/distributed-jwt-cracker.git"
    "https://github.com/Ruulian/CSPass.git"
    "https://github.com/google/csp-evaluator.git"
    "https://github.com/nicholasaleks/CrackQL.git"
    "https://github.com/MindPointGroup/cloudfrunt.git"
    "https://github.com/Tuhinshubhra/CMSeeK.git"
    "https://github.com/Dionach/CMSmap.git"
    "https://github.com/nikitastupin/clairvoyance.git"
    "https://github.com/michelin/ChopChop.git"
    "https://github.com/TarlogicSecurity/Chankro.git"
    "https://github.com/deibit/cansina/.git"
    "https://github.com/s0md3v/Blazy.git"
    "https://github.com/mazen160/bfac.git"
    "https://github.com/beefproject/beef.git"
    "https://github.com/NickstaDB/BaRMIe.git"
    "https://github.com/blacklanternsecurity/badsecrets.git"
    "https://github.com/b374k/b374k.git"
    "https://github.com/m4ll0k/Atlas.git"
    "https://github.com/flipkart-incubator/astra.git"
    "https://github.com/AmyangXYZ/AssassinGo.git"
    "https://github.com/s0md3v/Arjun.git"
    "https://github.com/michenriksen/aquatone.git"
    "https://github.com/Fuzzapi/API-fuzzer.git"
    "https://github.com/evilsocket/altair.git"
    "https://github.com/RapidDNS/Afuzz.git"
    "https://github.com/zan8in/afrog.git"
        "https://github.com/devanshbatham/FavFreak.git"
        "https://github.com/ffuf/ffuf.git"
        "https://github.com/Brum3ns/firefly.git"
        "https://github.com/pielco11/fav-up.git"
        "https://github.com/ssl/ezXSS.git"
        "https://github.com/RedSiege/EyeWitness.git"
        "https://github.com/whitel1st/docem.git"
        "https://github.com/wireghoul/dotdotpwn.git"
        "https://github.com/davtur19/DotGit.git"
        "https://github.com/SamJoan/droopescan.git"
        "https://github.com/immunIT/drupwn.git"
        "https://github.com/GoSecure/dtd-finder.git"
        "https://github.com/whitel1st/docem.git"
        "https://github.com/lmammino/distributed-jwt-cracker.git"
        "https://github.com/Ruulian/CSPass.git"
        "https://github.com/google/csp-evaluator.git"
        "https://github.com/nicholasaleks/CrackQL.git"
        "https://github.com/MindPointGroup/cloudfrunt.git"
        "https://github.com/Tuhinshubhra/CMSeeK.git"
        "https://github.com/Dionach/CMSmap.git"
        "https://github.com/nikitastupin/clairvoyance.git"
        "https://github.com/michelin/ChopChop.git"
        "https://github.com/TarlogicSecurity/Chankro.git"
        "https://github.com/deibit/cansina/.git"
        "https://github.com/s0md3v/Blazy.git"
        "https://github.com/mazen160/bfac.git"
        "https://github.com/beefproject/beef.git"
        "https://github.com/NickstaDB/BaRMIe.git"
        "https://github.com/blacklanternsecurity/badsecrets.git"
        "https://github.com/b374k/b374k.git"
        "https://github.com/m4ll0k/Atlas.git"
        "https://github.com/flipkart-incubator/astra.git"
        "https://github.com/AmyangXYZ/AssassinGo.git"
        "https://github.com/s0md3v/Arjun.git"
        "https://github.com/michenriksen/aquatone.git"
        "https://github.com/Fuzzapi/API-fuzzer.git"
        "https://github.com/evilsocket/altair.git"
        "https://github.com/RapidDNS/Afuzz.git"
        "https://github.com/zan8in/afrog.git"

    )

    # We sanitize the argument in case the user surrounds it with quotes.
    # If the user typed something like ""booty"" (with double quotes), this will remove them.
    local raw_dir="$1"
    local sanitized_dir
    sanitized_dir="$(sed -E 's/^\"+|\"+$//g' <<< "$raw_dir")"

    # If no argument or sanitized argument is empty, default to cloned_repos.
    local output_dir="${sanitized_dir:-cloned_repos}"

    mkdir -p "$output_dir"

    echo "[INFO]: Starting the cloning process."
    for repo in "${repos[@]}"; do
        local repo_name
        repo_name="$(basename "$repo" .git)"

        echo "[INFO]: Processing repository: $repo_name"

        # -----------------------------
        # CLONE OR PULL THE REPOSITORY
        # -----------------------------
        if [ ! -d "$output_dir/$repo_name" ]; then
            echo "[INFO]: Cloning $repo into $output_dir/$repo_name..."
            if ! git clone "$repo" "$output_dir/$repo_name"; then
                log_error "Failed to clone $repo. Skipping this repository..."
                continue
            fi
            echo "[INFO]: Successfully cloned $repo_name."
        else
            echo "[INFO]: $repo_name already exists. Pulling latest changes..."
            if ! (cd "$output_dir/$repo_name" && git pull); then
                log_error "Failed to pull changes for $repo_name. Skipping further steps for this repo..."
                continue
            fi
            echo "[INFO]: Successfully pulled latest changes for $repo_name."
        fi

        # ------------------------------------
        # CHECK FOR INSTALL SCRIPT & EXECUTE
        # ------------------------------------
        if has_install_script "$output_dir/$repo_name"; then
            echo "[INFO]: Found an installation script in $repo_name. Marking as executable and running..."
            chmod +x "$output_dir/$repo_name"/*install*.sh
            if ! (cd "$output_dir/$repo_name" && bash ./*install*.sh); then
                echo "[WARNING]: Could not run the installation script for $repo_name."
                # continue  # If you want to skip to the next repo on error, uncomment this.
            fi
        else
            echo "[INFO]: No installation script found for $repo_name."
            # ----------------------------------------------------------
            # CHECK IF IT IS PYTHON-BASED; IF SO, CREATE VENV AND INSTALL
            # ----------------------------------------------------------
            if is_python_repo "$output_dir/$repo_name"; then
                echo "[INFO]: $repo_name appears to be a Python repo. Creating virtual environment and installing."
                if ! cd "$output_dir/$repo_name"; then
                    log_error "Could not enter directory $output_dir/$repo_name. Skipping..."
                    continue
                fi

                python3 -m venv venv
                source venv/bin/activate

                if [[ -f "requirements.txt" ]]; then
                    echo "[INFO]: Installing from requirements.txt..."
                    pip install --upgrade pip
                    if ! pip install -r requirements.txt; then
                        log_error "Failed to install Python dependencies for $repo_name."
                        # continue  # Uncomment if you want to skip next steps for this repo.
                    fi
                elif [[ -f "setup.py" ]]; then
                    echo "[INFO]: Running setup.py install..."
                    pip install --upgrade pip
                    if ! python setup.py install; then
                        log_error "Failed to run setup.py install for $repo_name."
                        # continue
                    fi
                fi

                deactivate
                cd - >/dev/null || true

            else
                echo "[INFO]: $repo_name doesn't appear to be Python-based. Skipping venv setup."
            fi
        fi

        echo "[INFO]: Finished processing $repo_name."
        echo "--------------------------------------------------"
    done

    echo "[INFO]: All repositories have been processed."
    echo "[INFO]: Please review and understand the purpose of each repository before running or installing its contents."
}

# Example usage:
#   ./install.sh [output_directory]
# If no output_directory is provided, it defaults to "cloned_repos".

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    install_tools "$1"
fi

Install_security_and_network_tools() {
    echo "[+] Installing essential tools for network administration and security..."
    local tools=(
        net-tools tcpdump traceroute mtr iperf3 dnsutils whois tshark arp-scan ettercap-common dsniff
        metasploit-framework wireshark nmap aircrack-ng john hashcat zaproxy sqlmap hydra proxychains
        gobuster dirb checksec nikto wpscan macchanger responder bloodhound impacket-scripts
        crackmapexec seclists nishang powersploit enum4linux recon-ng tor xplico apache2 openvas
        netcat
    )

    # Example: apt-get install logic here, with error checks if you wish.   
    # ...
}
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    install_ddos_tools "$1"
fi
