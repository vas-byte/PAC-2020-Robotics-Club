#include <Braccio.h>
#include <Servo.h>


Servo base;
Servo shoulder;
Servo elbow;
Servo wrist_rot;
Servo wrist_ver;
Servo gripper;

int Robobase = 90;
int Roboelbow = 90;

void setup() {  
  //Initialization functions and set up the initial position for Braccio
  //All the servo motors will be positioned in the "safety" position:
  //Base (M1):90 degrees
  //Shoulder (M2): 45 degrees
  //Elbow (M3): 180 degrees
  //Wrist vertical (M4): 180 degrees
  //Wrist rotation (M5): 90 degrees
  //gripper (M6): 10 degrees
  Braccio.begin();
    // the arm is aligned upwards  and the gripper is closed
                     //(step delay, M1, M2, M3, M4, M5, M6);
  Braccio.ServoMovement(20,         90, 90, 90, 90, 90,  73);
  Serial.begin(9600);  
}

void loop() {
  /*
   Step Delay: a milliseconds delay between the movement of each servo.  Allowed values from 10 to 30 msec.
   M1=base degrees. Allowed values from 0 to 180 degrees
   M2=shoulder degrees. Allowed values from 15 to 165 degrees
   M3=elbow degrees. Allowed values from 0 to 180 degrees
   M4=wrist vertical degrees. Allowed values from 0 to 180 degrees
   M5=wrist rotation degrees. Allowed values from 0 to 180 degrees
   M6=gripper degrees. Allowed values from 10 to 73 degrees. 10: the toungue is open, 73: the gripper is closed.
  */
  

   
}
void serialEvent(){
  Serial.flush();
  String SerialData = Serial.readStringUntil('\n');
  int Angle = SerialData.toInt();
  
//  Serial.println("Interrupt");
//  Serial.println(SerialData.substring(1));
//  Serial.println(Angle);
  
  if(SerialData.substring(1) == "u"){
     if(Roboelbow < 180){
      Roboelbow += Angle;
      Braccio.ServoMovement(20,         Robobase, 90, Roboelbow, 90, 90,  73);
      Serial.print(Roboelbow);
      } 
  } else if (SerialData.substring(1) == "d") {
      if(Roboelbow > 0){
       Roboelbow -= Angle;
       Braccio.ServoMovement(20,         Robobase, 90, Roboelbow, 90, 90,  73);
       Serial.print(Roboelbow);
      } 
  } else if (SerialData.substring(1) == "l") {
     if(Robobase > 0){
      Robobase -= Angle;
      Braccio.ServoMovement(20,         Robobase, 90, Roboelbow, 90, 90,  73);
      Serial.print(Robobase);
      }
      
  } else if (SerialData.substring(1) == "r") {
      if(Robobase < 180){
      Robobase += Angle;
      Braccio.ServoMovement(20,         Robobase, 90, Roboelbow, 90, 90,  73);
      Serial.print(Robobase);
      }
  }
  
  }
