#!/bin/bash
versionname="1.0.0"
ACTION=${1}

function startservice() {
 sudo yum update -y
 sudo amazon-linux-extras install nginx1.12 -y
 ps ax | grep nginx | grep -v grep
 sudo service nginx start
 sudo chkconfig nginx on
 sudo aws s3 cp s3://zhan7829-assignment-webserver/index.html /usr/share/nginx/html/index.html
}

function removeservice() {
 sudo service nginx stop
 sudo rm -f  /usr/share/nginx/html/index.html 
 sudo yum remove nginx -y
}

function showversion() {
echo "Version of script is : $versionname"
}

function displayhelp() {
cat << EOF
Usage: ${0} {-r|--remove|-h|--help} <filename>
OPTIONS:
-h|--help  will display the help page.
-r|--remove  will remove the nginx server
-v|--version will display the version 
Examples:
	Display help:
		$ ${0} -h
EOF
}
case "$ACTION" in
	-h|--help)
		displayhelp
		;;
	-r|--remove)
		removeservice
		;;
	-v|--version)
		showversion
		;;
        "")
		startservice
		;;
	*)
	echo "Usage ${0} {-r|-h|-v}"
	exit1
esac
