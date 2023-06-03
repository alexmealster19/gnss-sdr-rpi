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
The CM4 has the same chip as the Pi4 therefore the performance is the same. However, the CM4 has a much smaller form factor and is more dificult to interface with. However, due to its small size it will be flown on OrCa2. To interface with the CM4, there are different IO boards. The IO board we have used for testing has ethernet, HDMI, and USB ports. The CM4 is typically located on the IO board in the clear bin in the back room of the lab.
#### Raspberry Pi Zero
The Pi Zero was thouroughly tested for GNSS-SDR however there was not enough RAM to get a position fix. 
#### BeagleBones Black
GNSS-SDR was never succesfully compiled onto the BBB due to a lack of space, and there are doubts as to whether or not the BBB would have the computing power to run GNSS-SDR. 


### SDR Periphreal 
An SDR periphreal is a device that when paired with a computer can act as an SDR. For simplicity, I will refer to SDR periphreals from this point forward just as SDRs. 
#### HackRF
The SDR mainly considered for this project is the HackRF by great Scott gadgets. The HackRF is cheap and easy to obtain. Plus it has a wide range of receiving and transmitting frequencies. For the purposes of this payload, the HackRF can be considered a plug and play. There is not need for additional setup. The HackRF is powered by and passed information through the microUSB port. The HackRF connects to an antenna and an oscialltor via SMA ports. 
#### RTL-SDR Dongle
The RTL-SDR dongle can be thought of as both a backup to the HackRF, in case there is an error with the HackRF, or as a great testing device. The main differences between the RTL-SDR dongle and the hackRF are: RTL-SDR dongle is smaller, significantly cheaper and can only receive signals / can't transmit. Additionally, the oscialltor in the RTL-SDR dongle is precise enough for GPS fixes, unlike the HackRF which requires an external oscillator.

### Oscillator 
#### LOTUS TCXO
The only oscillator that has been used succesfully in this project is the LOTUS temparture controlled crystal oscillator. The oscillator provided a steady signal for the SDR which allows for GPS signal correlation. Using the TCXO is very simple and can be viewed as plug and play. The output signal is transmitted via a SMA cable that runs to the clock in port of the hackRF. The TCXO is powered via a +3.3v and ground terminal. 
### Antenna
The antenna receives the L1 signals from the GPS satellites and makes a position fix possible. 
#### Magnetic GPS Antenna
Make sure that when using a Magnetic GPS antenna that you are grounding the anetenna by placing it on a ferris metal surface. This antenna is great for outdoor testing since it will not be flying.  
#### Tallysman Patch Antenna 
This is the antenna that will be flying on board OrCa2. The antenna has a 28 dB gain and requires a voltage bias. How to send a voltage bias will be discussed in the GNSS-SDR configurations section.   
#### In Line LNA
The in line Low Noise Amplifier (LNA) is used as part of a testing set up with the GPS simulator. Since the GPS simulator sends signlas directly into the hackRF without an antenna the impact of the antenna's LNA is unaccounted for. In order to account for the gain, an in line LNA can be placed in between the GPS simulator and the hackRF to increase the gain of the signal similarly to the antenna. The in line LNA has a gain of 25dB which is less than the antenna so the additional 3dB of gain can be accounted for via the GPS simulator.  

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
One of the best aspects of GNSS-SDR is the use of a .config file to configure the SDR receiver. The config file allows for the user to determine what type of data is being read in, the voltage being sent to the antenna, the frequency band being searched and much more. In the following sections I will describe the different configuration files I've created and the differences between them. You can find these configuartions in this repository under configs. If you want to understand more about GNSS-SDR configurations check [here](https://gnss-sdr.org/docs/sp-blocks/). 

#### rtl.conf
This configuration is used to run GNSS-SDR using an RTL-SDR dongle. The configuration has to be modified to account for the SDR periphreal being different from a hackRF. This configuration should only be used with the RTL-SDR dongle which I recomend using for any necessary outdoor real time testing.
#### realTime.conf
This configuration is for real time GPS fixes from the surface of the Earth using a hackRF. Good for testing but should only be used for hardware validation since the configuratioon in orbit is very different. Will require a bias voltage, antenna and oscillator. The voltage bias is sent to the antenna via the hackRF using this line in the config file 
```
SignalSource.osmosdr_args=rtl,bias=1
```

#### postProcessed.conf
The post processed config file takes only GPS signal data and performs a GPS fix on them. Old GPS signal data can be acquired following the steps detailed [here](https://gnss-sdr.org/my-first-fix/) in step 2. The lines the tells the SDR where to look is here 
```
SignalSource.implementation=File_Signal_Source
SignalSource.filename=/home/Mealey/work/2013_04_04_GNSS_SIGNAL_at_CTTC_SPAIN/2013_04_04_GNSS_SIGNAL_at_CTTC_SPAIN.dat
```
#### InOrbit.conf
As its name implies, the InOrbit.conf file is the configuration for OrCa2 while in orbit. This file is different in a few key ways. Firstly, the range of signals that the SDR looks for, dictated by the doppler shift, must be much greater since the relative velocites are greater in orbit than on the ground. This value is dictated in the config file by the line 
```
Acquisition_1C.doppler_max=
```

The reason the value is currently not set is that the Doppler value could be used to back out certain orbital parameters of OrCa2's orbit. Thus the file InOrbit.conf in the secure server has the correct value.

The other way that InOrbit.conf differs is by the number of satellites that the SDR will actively try to acquire at one time. The greater the number the faster a position fix is acheived but also the more processing power required from the computer. Thus, since the CM4 is the computer being flown the number of satellites in acquisition has been reduced to 2 to ensure the cmputer is not overloaded. This value is set in the config file by the line 
```
Channels.in_acquisition=2
```


#### gpsSim.conf
This configuration is meant to be used when testing with the GPS simulator. The gpsSim.conf file is almost exactly the same as the InOrbit.conf file. The only difference is that there is no bias being sent to the antenna since no antenna is used when testing on the simulator and it can be dangerous to send voltage into the expensive GPS simulator. Thus the line of code below is implemented. 
```
SignalSource.osmosdr_args=hackrf,bias=0
```

### Custom Bash Script for Testing and Running the software
I have created a custom bash script that will / stop run gnss-sdr when called. The script will start gnss-sdr when called if the program isn't already running, if the program is running the the script will stop the program. The custom bash script is called sdrPayload.sh in the execute folder. There is a change required to use this script however, the script should be modified to specify which gnss-sdr config you are running. For example, if you want to run the gps simulator config, you should change this line in the code
```
gnss-sdr &
```
to this (but make sure to change the path so that it matches the correct place in your file system).
```
gnss-sdr --config_file=/pathToConfigFile/gpsSim.conf &
```
The above line is also how you would run gnss-sdr from the command prompt.

## Testing
For testing there are a couple of different hardware and software configurations that should be used for each type of testing. This section will briefly tell you how to combine software and hardware for each testing case. 

### Flat Sat
On the flat sat you will be using the CM4, the hackRF, and the antenna (optional). Since the flat sat can not be moved to a location with a GPS signal, then I would use the postProcessed.conf with the old data provided by gnss-sdr (which is described more in the postProcessed.conf section. 
### GPS Simulator
When using the GPS simulator, you can use any combination of SDR and computer but I would recomend using the CM4 with the hackRF. The gpsSim.conf is the proper configuration for the simulator. TO actually use the simulator requires some training but at the end of the day is fairly straightforward. If instructions on how to use the gps simulator are required please email me at amealey3@gatech.edu and I can provide more details. 

### Real Time
If you want to test the setup by going outside you can use any combination of computer and SDR. However for this lab, DO NOT USE THE CM4. CM4s have been difficult to come by lately and we don't need to damage our CM4 before flight. I'd recomend using a laptop and the RTL-SDR dongle. 


