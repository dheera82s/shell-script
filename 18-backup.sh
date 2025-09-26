#!/bin/bash


R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14} # if user is not providing number of days, weare taking 14 as default
LOGS_FOLDER="/home/ec2-user/shellscript-logs"
LOG_FILE=$(echo $0 | awk -f "/"'{print $NF}' | cut -d "." -f1 )
TIMESTAMP=$(date +%y-%m-%d-%h-%M-%S)
LOG_FILE_NAME="$LOGS_FOLDER/$LOG_FILE-$TIMESTAMP.log"


USAGE(){
    #echo -e "$R USAGE:: $N sh 18-backup.sh <SOURCE_DIR> <DEST_DIR><DAYS(optional)>"
    echo -e "$R USAGE:: $N backup <SOURCE_DIR> <DEST_DIR><DAYS(optional)>"
    exit 1
}    

mkdir -p /home/ec2-user/shellscript-logs


if [ $# -lt 2 ]
then
    USAGE

fi

if [ ! -d $SOURCE_DIR ]
then
    echo -e "$SOURCE_DIR does not exist...please check"
    exit 1
fi 

echo "script started executing at: $TIMESTAMP" &>>$LOG_FILE_NAME 

FILES=$(find $SOURCE_DIR -name "*.log" -mtime +$DAYS)

if [ -n "$FILES" ]
then
    echo "files are: $FILES"
    ZIP_FILE="$DEST_DIR/app-logs-$TIMESTAMP.zip"
    find $SOURCE_DIR -name "*.log" -mtime +$DAYS | zip -@ "$ZIP_FILE"
    if [ -f "$ZIP_FILE" ]
    then
        echo -e "successfully created zip file for files older than $DAYS"
        while read -r filepath
        do
           echo "deleting file: $filepath" &>>$LOG_FILE_NAME
           rm -rf $filepath
           echo "deleted file: $filepath"
           done <<< $FILES
    else
        echo -e "$R error:: $N failed to create zip file"
        exit 1
    fi

else
    echo "no files found older than $DAYS"
fi

