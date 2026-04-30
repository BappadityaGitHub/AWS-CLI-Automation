#!/bin/bash

echo " my name is Abhishek"
echo " My name is rahul" 
echo " I  have no Name0"
echo " My name is Raja" 
echo " My name is Bappa"


# now run ./grep+awkCommand.sh | awk -F" " '{print $4}'you will only see names from 4th collum 
#we combine Pipe '|' to get rsult from one command then filter it using awk -F" " '{print $0}' according posotion of the collum#
