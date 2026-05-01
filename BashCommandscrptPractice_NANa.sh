#!/bin/bash 
# imaging log filr name apt.log and i have to find error 
# will run : grep "ERROR" apt.log
# to find number of error files in log 
# will run : grep -c "ERROR" apt.log
# grep -c "FATAL" apt.log # to find number of fatal logs
# if there are multple log files which i need to check daily i will run command that will only pull out chnages made in last 24 hours in those log files with out making me go through them all repeatedly daily 
# in the current directory will run : find . -name "*.log" -mtime -1 
# -mtime filters file based on modification time , -1 is last 24 hour time
# ## "*.log" should be double inverted commas as its string
# #### if we savel all the previous commands in one script and run that will be shell script
#touch analyse-logs.sh
#vim analyse-logs.sh
