# Remote Control Application for Braccio Robotic Arm

 - **Flutter** used to create frontend application
 - **NodeJS** hosts webserver that uses sockets to recieve incomming packets (UDP)
 - **Arduino** used to control robotic arm, connection established via USB Serial from Node webserver
 
## To Get Started
1. Update the IP Adress of the nodejs server in the flutter code
![enter image description here](https://github.com/vas-byte/PAC-2020-Robotics-Club/blob/main/images/ip%20config.png)
2. Update the serial port of the arduino on the node webserver
![enter image description here](https://github.com/vas-byte/PAC-2020-Robotics-Club/blob/main/images/serial%20config.png)
