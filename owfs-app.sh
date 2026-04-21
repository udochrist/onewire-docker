#! /bin/bash

# Start the first process: owserver
echo "Starting owserver"

/usr/bin/owserver -c /etc/owfs.conf
if [ $? -ne 0 ]; then
  echo "Failed to start owserver"
  exit 1
fi

# Start the second process: owhttpd
echo "Starting owhttpd"

/usr/bin/owhttpd -c /etc/owfs.conf
if [ $? -ne 0 ]; then
  echo "Failed to start owhttpd"
  exit 1
fi

# keep running forever
tail -f /dev/null
