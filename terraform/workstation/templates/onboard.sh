# logging
LOG_FILE=/var/log/startup-script.log
if [ ! -e $LOG_FILE ]
then
     touch $LOG_FILE
     exec &>>$LOG_FILE
else
    #if file exists, exit as only want to run once
    exit
fi

exec 1>$LOG_FILE 2>&1

# install docker
# install terraform locally
# install ansible locally
# tools
# jq curl
# xrdp install
# vscode remote
# install cloud shells
# gcloud
# azurecli
# awscli
# f5 cli
# auto completes

# ubuntu 18.04
# terraform 12.23?
# jq, curl
# awscli
# f5 cli

echo "=====done====="
exit