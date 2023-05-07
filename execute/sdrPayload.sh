#!/bin/bash

# Check if GNSS-SDR is already running
if pgrep -x "gnss-sdr" > /dev/null
then
    echo "GNSS-SDR is already running. Stopping GNSS-SDR."
    killall gnss-sdr
else
    echo "Starting GNSS-SDR."
    # Replace the command below with the command to start GNSS-SDR
    gnss-sdr &
fi
