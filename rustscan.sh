#!/bin/bash

# Checking if the user is root or not and forcing him to run as root to successfully run the script
if [[ "$EUID" -ne 0 ]]
then
    echo "[+] You are not root, please run the script as root."
    echo "[+] Usage: sudo ./rustscan.sh"
    exit 1
else
    echo "[+] Rust scan starting"
    read -p '[+] The IP address or the domain name you want to scan: ' DOMAIN
    echo "[+] Entered Domain Name: $DOMAIN"


    echo "USAGE:
        rustscan [FLAGS] [OPTIONS] [-- <command>...]

    FLAGS:
            --accessible    Accessible mode. Turns off features which negatively affect screen readers
        -g, --greppable     Greppable mode. Only output the ports. No Nmap. Useful for grep or outputting to a file
        -h, --help          Prints help information
        -n, --no-config     Whether to ignore the configuration file or not
            --top           Use the top 1000 ports
        -V, --version       Prints version information

    OPTIONS:
        -a, --addresses <addresses>...     A comma-delimited list or newline-delimited file of separated CIDRs, IPs, or
                                        hosts to be scanned
        -b, --batch-size <batch-size>      The batch size for port scanning, it increases or slows the speed of scanning.
                                        Depends on the open file limit of your OS.  If you do 65535 it will do every port
                                        at the same time. Although, your OS may not support this [default: 4500]
        -c, --config-path <config-path>    Custom path to config file
        -p, --ports <ports>...             A list of comma-separated ports to be scanned. Example: 80,443,8080
        -r, --range <range>                A range of ports with format start-end. Example: 1-1000
            --scan-order <scan-order>      The order of scanning to be performed. The \"serial\" option will scan ports in
                                        ascending order while the \"random\" option will scan ports randomly [default:
                                        serial]  [possible values: Serial, Random]
            --scripts <scripts>            Level of scripting required for the run [default: default]  [possible values:
                                        None, Default, Custom]
        -t, --timeout <timeout>            The timeout in milliseconds before a port is assumed to be closed [default: 1500]
            --tries <tries>                The number of tries before a port is assumed to be closed. If set to 0, rustscan
                                        will correct it to 1 [default: 1]
        -u, --ulimit <ulimit>              Automatically ups the ULIMIT with the value you provided

    ARGS:
        <command>...    The Script arguments to run. To use the argument -A, end RustScan's args with '-- -A'. Example:
                        'rustscan -T 1500 -a 127.0.0.1 -- -A -sC'. This command adds -Pn -vvv -p \$PORTS automatically to
                        nmap. For things like --script '(safe and vuln)' enclose it in quotation marks \"'(safe and
                        vuln)'\""

    read -p '[+] Enter the flags: ' FLAGS
    echo "[+] Your selected flags are: $FLAGS"

    read -p '[+] Enter the options listed above: ' OPTIONS
    echo "[+] Your selected options are: $OPTIONS"

    read -p '[+] Enter the commands: ' COMMANDS
    echo "[+] Your selected commands are: $COMMANDS"

    docker run -it --rm --name rustscan rustscan/rustscan:2.1.1 "$OPTIONS" "$DOMAIN" -- "$COMMANDS"
fi
