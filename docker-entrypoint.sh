#!/bin/bash

if [ "$SERVICE_TYPE" == "wServer" ]
then
    echo "Starting World Server..."
    mono --debug --gc=sgen ./wServer.exe
elif [ "$SERVICE_TYPE" == "server" ]
then
    echo "Starting App Engine Server..."
    mono --debug --gc=sgen ./server.exe
else
    echo "SERVICE_TYPE not set or invalid. Please set to 'server' or 'wServer'."
    exit 1
fi