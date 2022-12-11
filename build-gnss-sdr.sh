apt-get update
apt install hackrf
apt-get update
apt-get update --allow-releaseinfo-change
apt-get install build-essential cmake git pkg-config libboost-dev libboost-date-time-dev \
       libboost-system-dev libboost-filesystem-dev libboost-thread-dev libboost-chrono-dev \
       libboost-serialization-dev liblog4cpp5-dev libuhd-dev gnuradio-dev gr-osmosdr \
       libblas-dev liblapack-dev libarmadillo-dev libgflags-dev libgoogle-glog-dev \
       libgnutls-openssl-dev libpcap-dev libmatio-dev libpugixml-dev libgtest-dev \
       libprotobuf-dev protobuf-compiler python3-mako

git clone https://github.com/gnss-sdr/gnss-sdr
cd gnss-sdr/build
cmake -DENABLE_OSMOSDR=ON ../
make
make install


