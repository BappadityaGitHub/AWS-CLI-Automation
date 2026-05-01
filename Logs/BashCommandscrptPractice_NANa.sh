#!/bin/bash
echo "analysing log files"
echo "=================================" 
echo -e"\n finding List of log files in updated in last 24 hours"

find . -name "*.log" -mtime -1 # Finding which files have been updated in last 1 day 
# imaging log file name application.log and system.log and i have to find error or fatal or crital logs 
echo " searching error logs " 
grep "ERROR" application.log #to find ERROR files
echo -e"\n searching number of error and fatal logs " 
grep -c "ERROR" application.log # finding number of ERROR files
grep -c "FATAL" application.log #finding number of FATAL files
grep -c "FATAL" system.log # finding number of FATAL files
greo -c "CRITICAL" system.log # finding number of critilal files 
# if there are multple log files which i need to check daily i will run command that will only pull out chnages made in last 24 hours in those log files with out making me go through them all repeatedly daily 
# in the current directory will run : find . -name "*.log" -mtime -1 
# -mtime filters file based on modification time , -1 is last 24 hour time
# ## "*.log" should be double inverted commas as its string
# #### if we savel all the previous commands in one script and run that will be shell script
#touch analyse-logs.sh
# grep -c "FATAL" apt.#vim analyse-logs.sh
