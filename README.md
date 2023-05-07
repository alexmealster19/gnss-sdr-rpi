# HackRF Payload aboard OrCa2
## Overview
This repository is meant to assist members of the Georgia Tech SSDL BGRG in building, testing and deploying the HackRF payload aboard OrCa2. This read me page will detail the hardware setup, how to build and run the software and how to test the payload. The payload is set to run a program called GNSS-SDR to receive an in orbit position fix for OrCa2. 

Last Updated by Alex Mealey on May 7th

## Hardware 
There are four main components to consider with this payload. The computer, the software-defined radio(SDR) periphreal, the oscillator and the antenna. I will go into each of these in more depth now. All of these componenets can be found in the BGRG lab in the SDR drawer.  

### Computer
The computer is this case works with the SDR periphreal to work as a GPS receiver. There are a number of computers that have been successfully tested but there are some restraints. The computer is recomended to have 4 GB of RAM and at least 4.5 GB of storage. 
#### Laptop
I've been able to successfully run GNSS-SDR on my Macbook pro. The performance on the Macbook is quite good and is easy to install. To install GNSS-SDR onto a Macbook please follow the instructions [here](https://gnss-sdr.org/build-and-install/). You may run into issues install GNSS-SDR specfifically for the purpose of using SDRs. If that happens, I recomend checking [this link ](https://github.com/gnss-sdr/gnss-sdr/blob/main/README.md#build-and-install-gnss-sdr) and following the instructions for Macports. I haven't had much success using homebrew with gnss-sdr. Additionally, make sure that homebrew and macports are not both installed on your system otherwise GNSS-SDR will not compile correctly. 

#### Raspberry Pi 4
The Raspberry Pi 4 (or Pi4) has been used for the majority of GNSS-SDR testing. The Pi4 is cheap and relatively small but easier to interface with than the CM4 so it is great for testing. We've been able to run GNSS-SDR on a number of different operating systems with the Pi4. We were able to run gnss-sdr on the Pi4 with raspbian (the Raspberry pi version of Debian) version Buster, Debian version bookworm (not stable) and Ubuntu for the raspberry pi. It should be noted that GNSSS-SDR does not run on Raspbian Bullseye. To cooperate with the restraints of the raspberry pi camera payload, the Ubuntu OS is the one that will be flying. This OS is only command line, meaning there is no desktop interface.

The Pi4 has enough RAM to get a position fix, however there are times where CPU becomes overloaded. The user will know this is happening when GNSS-SDR begins outputting zeros. This can be mitigated by changing the number of satellites in acquisition in the GNSS-SDR config file (see software section).

#### CM4
The CM4 has the same chip as the Pi4 therefore the performance is the same. However, the CM4 has a much smaller form factor and is more dificult to interface with. However, due to its small size it will be flown on OrCa2. To interface with the CM4, there are different IO boards. The IO board we have used for testing has ethernet, HDMI, and USB ports. The CM4 is typically located on the IO board in the clear bin in 
#### Raspberry Pi Zero
The Pi Zero was thouroughly tested for GNSS-SDR however there was not enough RAM to get a position fix. 
#### BeagleBones Black
GNSS-SDR was never succesfully compiled onto the BBB due to a lack of space, and there are doubts as to whether or not the BBB would have the computing power to run GNSS-SDR. 


### SDR Periphreal 
An SDR periphreal is a device that when paired with a computer can act as an SDR. For simplicity, I will refer to SDR periphreals from this point forward just as SDRs. 
#### HackRF
The SDR mainly considered for this project is the HackRF by great Scott gadgets. The HackRF is cheap and easy to obtain. Plus it has a wide range of receiving and transmitting frequencies. For the purposes of this payload, the HackRF can be considered a plug and play. There is not need for additional setup. The HackRF is powered by and passed information through the microUSB port. The HackRF connects to an antenna and an oscialltor via SMA ports. 
#### RTL-SDR Dongle
The RTL-SDR dongle can be thought of as both a backup to the HackRF, in case there is an error with the HackRF, or as a great testing device. The mian differences between the RTL-SDR dongle and the hackRF are: RTL-SDR dongle is smaller, significantly cheaper and can only receive signals / can't transmit. Additionally, the oscialltor in the RTL-SDR dongle is precise enough for GPS fixes, unlike the HackRF which requires an external oscillator.

### Oscillator 
#### LOTUS TCXO
### Antenna
#### Magnetic GPS Antenna
Make sure that when using a Magnetic GPS antenna that you are grounding the anetenna by placing it on a ferris metal surface. 
#### Tallysman Patch Antenna 
#### In Line LNA

## Software: GNSS-SDR
The GNSS-SDR software is very well documented and open source. The program utilizes GNU radio and allows users to alter the GPS receiver configuartion through a single text file. 
### Build Software
This build method has been successfully used on both debian and ubuntu for raspberry pi. Note that many of these commands will require sudo privlidges so either run `sudo -s` early on or preface every command with `sudo`. The process is as follows:

```
apt install git
git clone https://github.com/alexmealster19/gnss-sdr-rpi.git
apt-get update
```

Now install the software packages to interface with the HackRF
```
apt install hackrf
apt-get update
apt-get update --allow-releaseinfo-change
```
Build the required packages for GNSS-SDR. If asked to restart services just click ok. 
```
cd Mealey/gnss-sdr-rpi/build
chmod u+x longCommand.sh
./longCommand.sh (this one will take a while)
```
Finally, make GNSS-SDR. This process can take up to 5 hours. 
```
git clone https://github.com/gnss-sdr/gnss-sdr
cd gnss-sdr/build
cmake -DENABLE_OSMOSDR=ON ../
make 
make install
volk_profile
volk_gnsssdr_profile
```
To check that it installed properly run `gnss-sdr --version`. If you get back `gnss-sdr version 0.0.18` you are in good shape!


### GNSS-SDR Configurations
### Custom Bash Script for Testing
### Run Software 

## Testing
### Flat Sat
### GPS Simulator
### Real Time

## Performance


