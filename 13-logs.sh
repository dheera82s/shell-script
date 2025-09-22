#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
LOGS_FOLDER="/var/log/shellscript-logs"
LOG_FILE=$(echo $0 | cut -d "." -f1 )
TIMESTAMP=$(date +%y-%m-%d-%h-%M-%S)
LOG_FILE_NAME="$LOGS_FOLDER/$LOG_FILE-$TIMESTAMP.log"

VALIDATE(){
    if [ $1 -ne 0 ]
    then 
        echo -e "$2 ... $R FAILURE $N"
        exit 1
    else
        echo -e "$2 ... $G SUCCESS $N"
    fi  
}

echo "script started executing at: $TIMESTAMP" &>>$LOG_FILE

if [ $USERID -ne 0 ]
then
    echo "ERROR:: you must have access to execute this script"
    exit 1 #other than 0
fi  
   
dnf list installed mysql &>>$LOG_FILE 

if [ $? -ne 0 ]
then # not installed
    dnf install mysql -y &>>$LOG_FILE
    VALIDATE $? "INSTALLING MYSQL"   
else
    echo -e "mysql is already ... $Y INSTALLED $N"
fi               

       
dnf list installed git &>>$LOG_FILE

if [ $? -ne 0 ]
then
    dnf install git -y &>>$LOG_FILE
    VALIDATE $? "INSTALLING Git"
else 
    echo -e "git is already ... $Y INSTALLED $N"
fi  