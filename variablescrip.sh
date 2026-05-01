#!/bin/bash
# ######################
# Variables
# ######################
# varivales are used to not keep writing commands paths or datas in every different situation from the beiginning #
# so we assignle varibale to the changing parts for the script/command exmaple LOG-File-Name , Log-Diretory-path
# and if add $ before log file name and log directory path and ask user imput the value system will generate the data by using the value/user entered log file name or directory path
# let see 
echo "analysing log files"
echo "================================="
echo -e "\n finding List of log files in updated in last 24 hours"

echo "which log file you want to analyse"

LOG_FILE_PATH="/c/Users/Me/AWS-CLI-Automation/Logs/" ### this LOG_FILE_PATH is VArriabel
LOG_FILE_NAME="application.log" 
LOG_FILE_NAME="system.log"   #### this LOG_FILE_NAME is varribale


read -p "enter the log file path or paste :" LOG_FILE_PATH

find $LOG_FILE_PATH -name "*.log" -mtime -1   #### we will be providing absolute path for the script to work from anywhere after example /c/Users/Me/AWS-CLI-Automation/Logs

## we make the value retured by the above command a variable by doing following 
LOG_FILE_NAMES=$(find $LOG_FILE_PATH -name "*.log" -mtime -1)

echo "Here are the Log files" "$LOG_FILE_NAMES"

echo "which log file you want to analyse"

read -p "enter log file name" LOG_FILE_NAME :  

#########
#Array Variable - that can have multiple optional choice 
##Example Error Pattern 

ERROR_PATTERN=("ERROR" "FATAL" "CRITICAL") # ***TO access from this variable systyem assigns index like "ERROR"=0 "FATAL"=1 AND so on

echo " searching error logs "

grep "$0" $LOG_FILE_PATH/$LOG_FILE_NAME #to find ERROR files

echo -e "\n searching number of error and fatal logs "

grep -c "${ERROR_PATTERNS[0]}" "$LOG_FILE_PATH/$LOG_FILE_NAME" # finding number of ERROR files

grep -c "${ERROR_PATTERNS[0]}" "$LOG_FILE_PATH/$LOG_FILE_NAME" #finding number of FATAL files

grep -c "${ERROR_PATTERNS[0]}" "$LOG_FILE_PATH/$LOG_FILE_NAME" # finding number of FATAL files

grep -c "${ERROR_PATTERNS[0]}" "$LOG_FILE_PATH/$LOG_FILE_NAME" # finding number of critilal 
