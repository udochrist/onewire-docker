#! /bin/bash
#
# healthcheck script for owfs docker container
#
echo -n "running:"

ps aux |grep owserver |grep -q -v grep
if [ $? -ne 0 ]; then
    echo " -owserver"
    exit 1
fi
echo -n " +owserver"

RESULT=0
if [ "${START_OWHTTPD}" = "true" ]; then

    ps aux |grep owhttpd  |grep -q -v grep
    if [ $? -ne 0 ]; then
        echo " -owhttpd"
        RESULT=1
    else
        echo -n " +owhttpd"
    fi
fi


if [ "${START_OWFS}" = "true" ]; then

    ps aux |grep owfs  |grep -q -v grep
    if [ $? -ne 0 ]; then
        echo " -owfs"
        RESULT=1
    else
        echo -n " +owfs"
    fi
fi

exit ${RESULT}