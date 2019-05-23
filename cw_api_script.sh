#!/bin/bash

#Enter your Email id and API key here
email_id='Your_Email_Id_Here'
api_key='Your_API_Key_Here'

#Authentication API URL
OAuth_API='https://api.cloudways.com/api/v1/oauth/access_token'

#This call will fetch access token, token type, expiring time (in seconds) and stores it in variable OAuth
OAuth=$(curl -X POST --header 'Content-Type: application/x-www-form-urlencoded' --header 'Accept: application/json' -d 'email='$email_id'&api_key='$api_key ${OAuth_API})
echo " "

#Seperating access token from OAuth
access_token=$(grep -Po '"'"access_token"'"\s*:\s*"\K([^"]*)' <<< "$OAuth")
echo "Access Token:" $access_token
echo " "

#Seperating token type from OAuth
token_type=$(grep -Po '"'"token_type"'"\s*:\s*"\K([^"]*)' <<< "$OAuth")
echo "Token Type:" $token_type
echo " "

#Using API's with access token

#To get list of Deployed Servers and all of its Information including sensitive credentials
echo "Getting Information of Deployed Servers"
curl -X GET --header 'Accept: application/json' --header 'Authorization: Bearer '$access_token 'https://api.cloudways.com/api/v1/server'
echo " "

#To change master username and password of the server

#Enter your server id, new username, new password here
server_id='Your_Server_Id_Here'
new_usrname='Your_New_Master_User_Name_Here'
new_passwd='Your_New_Master_Password_Here'

#This request will change master username
echo "Changing Master User Name"
curl -X POST --header 'Content-Type: application/x-www-form-urlencoded' --header 'Accept: application/json' --header 'Authorization: Bearer '$access_token -d 'server_id='$server_id'&username='$new_usrname 'https://api.cloudways.com/api/v1/server/manage/masterUsername'
echo " "
#This request will change master password
echo "Changing Master user Password"
curl -X POST --header 'Content-Type: application/x-www-form-urlencoded' --header 'Accept: application/json' --header 'Authorization: Bearer '$access_token -d 'server_id='$server_id'&password='$new_passwd 'https://api.cloudways.com/api/v1/server/manage/masterPassword'
echo " "

#To start the backup server operation
echo "Starting Backup of Server"
curl -X POST --header 'Content-Type: application/x-www-form-urlencoded' --header 'Accept: application/json' --header 'Authorization: Bearer '$access_token -d 'server_id='$server_id 'https://api.cloudways.com/api/v1/server/manage/backup'
echo " "
