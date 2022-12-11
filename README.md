# gnss-sdr-rpi
## Getting Started
This repository is designed to help users build and execute GNSS-SDR on a raspberry pi. Specifically GNSS-SDR that is meant to be run with a hack-rf one and with real time data.  This has been tested successfully on raspberry pi4 running raspbian buster and is in the midst of being tested on a raspberry pi zero. NOTE: This will not work for a raspberry pi running raspbian bullseye.  

First thing you should do is clone this respository using the below command. Unsure that you are using a raspberry pi that is connected to the internet via wifi or ethernet. 

```
git clone https://github.com/alexmealster19/gnss-sdr-rpi.git
```

## Installing GNSS-SDR
To install GNSS-SDR onto a raspberry pi you can follow the instructions on https://github.com/gnss-sdr/gnss-sdr/blob/main/README.md#build-and-install-gnss-sdr. However, if you don't want to copy and paste all the commands you can simply install using the shell scripts provided below. NOTE: Executing shell scripts from online is a really bad idea because you're giving alot of power to the script.

Navigate into the gnss-sdr-rpi folder. Make the build shell script executable by using

```
sudo chmod +x build-gnss-sdr.sh

```

Then build gnss-sdr by using. NOTE: This shell script builds gnss-sdr to be used on real time data from a hackrf. Thus it will install the hackrf package.

```
./build-gnss-sdr.sh

```

This will take a long time (on the raspberry pi 4 it takes about 2 hours). Once it has finished run the following command to ensure that everything is installed correctly. 

```
gnss-sdr --version
```

You should see something like ```gnss-sdr version 0.0.17```

If you don't I would recomend wiping the SD card and trying again using the instructions from the official GNSS-SDR github. If it works then run the commands:

```volk_profile```
```volk_gnsssdr_profile```

This will also take a while (upwards of 2 hours). Once you've completed these steps you are officially ready to run GNSS-SDR!

## Running GNSS-SDR
There are three different scenarios that I will discuss in this github. There is the post processing data scenario, the real time ground scenario and the in orbit scenario. Each has differences in their configuration files that I will discuss. 

### Post Processing GPS data
This is the most basic and easiest case to run. I recomend going through this process even if you don't need to process old data. First thing is downloading the data. If you cloned this repository then it will be in the gnss-sdr-rpi folder. 

### Real time signals from the ground
This is a really exciting scenario! For this case you will have to take your setup outside and obtain your actual position fix! In terms of physical set up you will need a raspberry pi with gnss-sdr installed, a hackRF, an oscialltor and an antenna. See the hardware section below for information on each hardware component. With the raspberry pi connected to power, plug the hackrf into one of the usb ports using the given cable. Run the command ```hackrf_info``` to ensure connection. It should output that it found the board and some basic information about your hackrf. If it outputs board not found check your connection. If it says there is no hackrf_info command then install hackrf using ```apt install hackrf```. 
