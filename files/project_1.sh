    #!/bin/bash
    #Author: Jace Alexander
    #Usage: This is a script that is useful for checking the health and usage of the server.
    
    # Displays the current date 
    date;

    # Display server up time
    echo "uptime:"
    uptime

    # Displays current connections
    echo "Currently connected:"
    echo "--------------------"

    # Display list of recent logins
   	# last -a returns a list of past logins, and head -3 grabs only the top 3.
    echo "Last logins:"
    last -a |head -3
    echo "--------------------"

    # Display Disk usage
    echo "Disk and memory usage:"
    # df (Disk Free) displays the free disk space of partitions, and the -h flag makes it human readable 
    # xargs grabbs the output from df -h, and awk parses the folling text using values from xargs
    # $11 corresponds to the usage percentage of udev and $9 to the used bytes
    df -h | xargs | awk '{print "Free/total disk: " $11 " / " $9}'
    # free displays the free and used memory of entire drive, the m flag converts the output to megabytes
    # xargs grabs the output from free -m and passes it to awk which does string replacements
    free -m | xargs | awk '{print "Free/total memory: " $17 " / " $8 " MB"}'
    echo "--------------------"

    # Grab the recent messages from the log, remove the first message and get the first 12
    start_log=`head -1 /var/log/messages |cut -c 1-12`
    # Contextualize the messages file and close it so that the script executes properly
    oom=`grep -ci kill /var/log/messages`
    echo -n "OOM errors since $start_log :" $oom
    echo ""
    echo "--------------------"

    # Display cpu usage and expensive processes
    echo "Utilization and most expensive processes:"
    # top displays a list of basic system information as well as real-time list of processes and threads
    # -b puts top in batch mode, which allows its output to redirected, while head -3 grabs the top 3 results
    top -b |head -3
    echo
    # Grab the top 10 and last 4 of the running processes information and display it
    top -b |head -10 | tail -4
    echo "--------------------"

    # Display list of open ports 
    echo "Open TCP ports:"
    # Display list of open TCP ports on the localhost at 'moderately fast' (T4) speed
    # nmap -p- only scans TPC ports
    nmap -p- -T4 127.0.0.1
    echo "--------------------"

    # Display list of current connections
    echo "Current connections:"

    # ss displays a list of sockets and the -s flag returns a summary
    ss -s
    echo "--------------------" 
    echo "processes:"
    ps auxf --width=200
    echo "--------------------"

    # Display vm statistics 
    echo "vmstat:"
    vmstat 1 5