#! /bin/bash

# Naive check runs checks once a minute to see if either of the processes exited.
# This illustrates part of the heavy lifting you need to do if you want to run
# more than one service in a container. The container exits with an error
# if it detects that either of the processes has exited.
# Otherwise it loops forever, waking up every 60 seconds


echo -n "running:"

ps aux |grep owserver |grep -q -v grep
if [ $? -ne 0 ]; then
    echo " -owserver"
    exit 1
fi
echo -n " +owserver"


ps aux |grep owhttpd  |grep -q -v grep
if [ $? -ne 0 ]; then
    echo " -owhttpd"
    exit 1
fi
echo -n " +owhttpd"

exit 0