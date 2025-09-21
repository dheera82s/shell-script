#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "ERROR:: you must have access to execute this script"
    exit 1 #other than 0
fi  
   
dnf install mysql -y

if [ $? -ne 0 ]
then 
    echo "installing MYSQL ... FAILURE"
    exit1
else
    echo "installing MYSQL ... SUCCESS"
fi        
  dnf install git -y

if [ $? -ne 0 ]
then 
    echo "installing git ... FAILURE"
    exit1
else
    echo "installing git ... SUCCESS"
fi        
  