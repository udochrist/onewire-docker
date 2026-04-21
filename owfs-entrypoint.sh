#! /bin/bash

if [ ! -f /config/owfs.conf ]; then
  cp /etc/owfs.conf.template /config/owfs.conf
fi

# Start owserver
echo "Starting owserver"

/usr/bin/owserver -c /config/owfs.conf
if [ $? -ne 0 ]; then
  echo "Failed to start owserver"
  exit 1
fi

# Start owhttpd
echo "Starting owhttpd"

/usr/bin/owhttpd -c /config/owfs.conf
if [ $? -ne 0 ]; then
  echo "Failed to start owhttpd"
  exit 1
fi

# Start owfs
echo "Starting owf"

/usr/bin/owfs -c /config/owfs.conf
if [ $? -ne 0 ]; then
  echo "Failed to start owfs"
  exit 1
fi

# keep running forever
tail -f /dev/null
