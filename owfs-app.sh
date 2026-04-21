#! /bin/bash

# Start the first process: owserver
echo "Starting owserver"

/usr/bin/owserver -c /etc/owfs.conf
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start 'owserver': $status"
  exit $status
fi

# Start the second process: owhttpd
echo "Starting owhttpd"

/usr/bin/owhttpd -c /etc/owfs.conf
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start 'owhttpd': $status"
  exit $status
fi

# keep running forever
tail -f /dev/null