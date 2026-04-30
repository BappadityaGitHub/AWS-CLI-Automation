#!/bin/bash 

## command ps -ef . p= process detaisl f=full format , without f we will only see few details
#when this command shows the resuts from the result if we have to find a specific process data and ID we use
##command grep 
## ps -ef | grep "amazon" amzon = example process name , '|'= pipe used to send value of 1st command from left side to 2nd command on right side of '|' 

##the example                 

ps -ef | grep "amazon"


