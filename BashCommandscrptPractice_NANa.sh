#!/bin/bash
echo "analysing log files"
echo "=================================" 
echo -e"\n finding List of log files in updated in last 24 hours"

#run find . -name "*.log" -mtime -1 # "." after find stands for current directory , in that Finding which files have been updated in last 1 day 
find /c/Users/Me/AWS-CLI-Automation/Logs -name "*.log" -mtime -1   #### we will be providing absolute path for the script to work from anywhere after example /c/Users/Me/AWS-CLI-Automation/Logs  
# imaging log file name application.log and system.log and i have to find error or fatal or crital logs 
echo " searching error logs " 
grep "ERROR" /c/Users/Me/AWS-CLI-Automation/Logs/application.log #to find ERROR files
echo -e "\n searching number of error and fatal logs " 
grep -c "ERROR" /c/Users/Me/AWS-CLI-Automation/Logs/application.log # finding number of ERROR files
grep -c "FATAL" /c/Users/Me/AWS-CLI-Automation/Logs/application.log #finding number of FATAL files
grep -c "FATAL" /c/Users/Me/AWS-CLI-Automation/Logs/system.log # finding number of FATAL files
grep -c "CRITICAL" /c/Users/Me/AWS-CLI-Automation/Logs/system.log # finding number of critilal files 
# if there are multple log files which i need to check daily i will run command that will only pull out chnages made in last 24 hours in those log files with out making me go through them all repeatedly daily 
# in the current directory will run : find . -name "*.log" -mtime -1 
# -mtime filters file based on modification time , -1 is last 24 hour time
# ## "*.log" should be double inverted commas as its string
# #### if we save all the previous commands in one script and run that will be shell script
#touch analyse-logs.sh
# grep -c "FATAL" apt.
#
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

LOG_FILE_PATH="/c/Users/Me/AWS-CLI-Automation/Logs/"
LOG_FILE_NAME="application.log ; system.log"


read -p "enter the log file path or paste" LOG_FILE_PATH

find $LOG_FILE_PATH -name "*.log" -mtime -1   #### we will be providing absolute path for the script to work from anywhere after example /c/Users/Me/AWS-CLI-Automation/Logs

echo "which log file you want to analyse"

read -p "enter log file name" LOG_FILE_NAME



echo " searching error logs "

grep "ERROR" $LOG_FILE_PATH/$LOG_FILE_NAME #to find ERROR files

echo -e "\n searching number of error and fatal logs "

grep -c "ERROR" $LOG_FILE_PATH/$LOG_FILE_NAME # finding number of ERROR files

grep -c "FATAL" $LOG_FILE_PATH/$LOG_FILE_NAME #finding number of FATAL files

grep -c "FATAL" $LOG_FILE_PATH/$LOG_FILE_NAME # finding number of FATAL files

grep -c "CRITICAL" $LOG_FILE_PATH/$LOG_FILE_NAME # finding number of critilal 
