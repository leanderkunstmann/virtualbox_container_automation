#!/bin/bash

# Start the first process
./run.sh -D
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start my_first_process: $status"
  exit $status
fi

# Start the second process
novnc/utils/launch.sh --vnc localhost:3389 --listen 5901
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start my_second_process: $status"
  exit $status
fi




