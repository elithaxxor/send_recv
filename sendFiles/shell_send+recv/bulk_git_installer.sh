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
        "https://github.com/cipher387/awesome-grep.git"
"https://github.com/MoserMichael/rzgrep.git"
"https://github.com/TUVIMEN/reliq.git"
"https://github.com/awgn/cgrep.git"
"https://github.com/o-oconnell/mp4grep.git"
"https://github.com/codypierce/hackers-grep.git"
"https://github.com/grosser/pru.git"
"https://github.com/fulcrumgenomics/fqgrep.git"
"https://github.com/vrothberg/vgrep.git"
"https://github.com/davidonzo/apiosintDS.git.git"
"https://github.com/fawazahmed0/cloudflare-trace-api.git.git"
"https://github.com/cipher387/awesome-grep.git.git"
"https://github.com/Josue87/EmailFinder.git.git"
"https://github.com/IxAmxZer0/Wifi-Biter.git.git"
"https://github.com/calebmadrigal/trackerjacker.git.git"
"https://github.com/t6x/reaver-wps-fork-t6x.git.git"
"https://github.com/aircrack-ng/mdk4.git.git"
"https://github.com/xtr4nge/FruityWifi.git.git"
"https://github.com/entropy1337/infernal-twin.git.git"
"https://github.com/Ledger-Donjon/intel-wifi-research-tools.git.git"
"https://github.com/virtualabs/btlejack.git.git"
"https://github.com/davidonzo/apiosintDS.git.git"
"https://github.com/fawazahmed0/cloudflare-trace-api.git.git"
"https://github.com/cipher387/awesome-grep.git.git"
"https://github.com/Josue87/EmailFinder.git.git"
"https://github.com/IxAmxZer0/Wifi-Biter.git.git"
"https://github.com/calebmadrigal/trackerjacker.git.git"
"https://github.com/t6x/reaver-wps-fork-t6x.git.git"
"https://github.com/aircrack-ng/mdk4.git.git"
"https://github.com/xtr4nge/FruityWifi.git.git"
"https://github.com/entropy1337/infernal-twin.git.git"
"https://github.com/Ledger-Donjon/intel-wifi-research-tools.git.git"
"https://github.com/virtualabs/btlejack.git.git"
"https://github.com/aircrack-ng/aircrack-ng.git"
"https://github.com/virtualabs/btlejack.git"
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
"https://github.com/aircrack-ng/aircrack-ng.git"
"https://github.com/virtualabs/btlejack.git"
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
"https://github.com/aircrack-ng/aircrack-ng.git"
"https://github.com/virtualabs/btlejack.git"
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
"https://github.com/aircrack-ng/aircrack-ng.git"
"https://github.com/virtualabs/btlejack.git"
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
"https://github.com/kimocoder/wifite2.git"
"https://github.com/DanMcInerney/wifijammer.git"
"https://github.com/IxAmxZer0/Wifi-Biter.git"
"https://github.com/calebmadrigal/trackerjacker.git"
"https://github.com/penthertz/rf-swift.git"
"https://github.com/t6x/reaver-wps-fork-t6x.git"
"https://github.com/P1sec/QCSuper.git"
"https://github.com/Synacktiv-contrib/Modmobmap.git"
"https://github.com/aircrack-ng/mdk4.git"
"https://github.com/kismetwireless/kismet.git"
"https://github.com/Ledger-Donjon/intel-wifi-research-tools.git"
"https://github.com/entropy1337/infernal-twin.git"
"https://github.com/chrisk44/Hijacker.git"
"https://github.com/xtr4nge/FruityWifi.git"
"https://github.com/KURO-CODE/Crunch-Cracker.git"
"https://github.com/virtualabs/btlejack.git"
"https://github.com/v1s1t0r1sh3r3/airgeddon.git"
"https://github.com/DanMcInerney/wifijammer.git"
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
