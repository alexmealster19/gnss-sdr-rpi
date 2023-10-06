import serial
import time
import random
import subprocess

ser = serial.Serial('/dev/ttyS0', 115200) #serial line to BBB
message = 'alex rules'
try:
    while True:
	  print('Search for message')
	    if (ser.in_waiting > 0): #if there is a serial message
	        message = ser.read_all().decode('utf-8')
		print('message received')
	    if (message=="science"):
	        confirmation_message = 'Look mom I am doing science!'
	    	ser.write(confirmation_message.encode('utf-8'))
	    if (message=="send starfield"):
		confirmation_message = 'Sending starfield'
		ser.write(confirmation_message.encode('utf-8'))
	    if (message=="science"):
		confirmation_message = 'Sending gps data'
		ser.write(confirmation_message.encode('utf-8'))
	    if (message=="lib-csp"):
	        confirmation_message = 'Sending via lib csp'
		ser.write(confirmation_message.encode('utf-8'))
        
	    time.sleep(2)    

except KeyboardInterrupt:
    ser.close()
 

