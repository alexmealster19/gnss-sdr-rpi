#!/usr/bin/expect -f
# This is a script to run and quit GNSS-SDR

# Set the path to the GNSS-SDR executable
set GNSS_SDR_EXECUTABLE "/path/to/gnss-sdr"

# Set the path to the configuration file
set CONFIG_FILE "/path/to/config_file.conf"

# Set the path to the output directory
set OUTPUT_DIRECTORY "/path/to/output_directory"

# Run GNSS-SDR in the background
spawn ${GNSS_SDR_EXECUTABLE} -c ${CONFIG_FILE} -o ${OUTPUT_DIRECTORY}

# Wait for GNSS-SDR to start
expect "Welcome to GNSS-SDR"

# Wait for the user to press 'q' and 'Enter' sequentially
expect "Press 'q' and 'Enter' sequentially to quit..."

# Send 'q' and 'Enter' to quit GNSS-SDR
send "q\r"

# Wait for GNSS-SDR to quit
expect "Quitting GNSS-SDR..."

# Exit the script
exit
