#!/bin/bash
export SSHPASS="L@ndis20@"


HOST='172.20.13.198'
USER='sftpuser'
REMOTEPATH='/home/NOC/'
file_name='/home/unirede/teste/endpointTotal.csv'


sshpass -e sftp $USER@$HOST <<EOF
cd $REMOTEPATH
put $file_name
EOF
