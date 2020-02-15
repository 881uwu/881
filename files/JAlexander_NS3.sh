#!/bin/bash
#Author: Jace Alexander
#Usage: This script will be useful for getting every port you want to look at for the nmap search.
# # # # # # # 

# This if statement is used for a way to force you to run it in either root or in sudo.
if [[ $EUID -ne 0 ]]; then
	echo "Run this script with sudo or root"
	exit 1
fi
#I am using this statement as a way for the user to input the ip they want to nmap and get to use.
echo "What starting IP subnet do you want to start with?"
read startip
echo "what ending IP subnet that you want to end with? Don't forgot to only enter the last octet"
read endip
# This statment is to remind the user that they only need to input the last octet to get the scan done.
nmap -A -T4 -p 25,80,110,143,587,993,995,4444,5190 $startip-$endip -oN JAlexander_Project1.3.txt
#The nmap tool here is using -A to use OS detection, version detection, traceroute, and script scanning.
#The -T4 statement is used as a T4 timing as aggressive scan.