#!/bin/bash

###########
# Author: Bappaditya
# Date: 29/04/2026 
#
#
# This script lays out the node health
#
#Version of Script V1 - I will keep updating the version on the same scrpt with newer additions on command
############

df -h
#printing/showing disk space

free -g
# printing memory 
###The free command is a Linux-specific utility. Even though you are using Git Bash, which "emulates" a Linux-like environment on your laptop, it is still running on top of the Windows Operating System.
##For windows system info we have to run the following
#systeminfo | grep "Memory"
#Logic: This runs the Windows systeminfo tool and uses the Linux grep to filter for memory.

nproc
#printing resources & process 


