#! /bin/bash

# Copy the default configuration file to the config directory to ensure there is always the current template
cp /etc/owfs.conf.template /config/owfs.conf.template

#  First run will use the template per default
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
if [ "${START_OWHTTPD}" = "true" ]; then

  echo "Starting owhttpd"

  /usr/bin/owhttpd -c /config/owfs.conf
  if [ $? -ne 0 ]; then
    echo "Failed"
    exit 1
  fi

fi

if [ "${START_OWFS}" = "true" ]; then

  # Start owfs
  echo "Starting owfs"

  /usr/bin/owfs -c /config/owfs.conf
  if [ $? -ne 0 ]; then
    echo "Failed"
    exit 1
  fi

fi

# keep running forever
tail -f /dev/null
