
import processing.serial.*;
import net.java.games.input.*;
import org.gamecontrolplus.*;
import org.gamecontrolplus.gui.*;
import cc.arduino.*;
import org.firmata.*;

//Initialize the arduino & controller as objects using the library above
ControlDevice controller;
ControlIO control;
Arduino arduino;

//Initialize ROV parts as objects
Thruster lThruster = new Thruster();
Thruster rThruster = new Thruster();
Light lightObj = new Light(); 
CamControl camCont = new CamControl();
TopThruster TThruster = new TopThruster();

//Set up controller to work with the Arduino using the fermata communication 
//protocol and also initializes servo pulsus for the respective Servo Motors.
void setup() {

  size(200, 150);
  control = ControlIO.getInstance(this);
  controller = control.getMatchedDevice("ROVController");
  // If no controller is found
  if (controller == null) {
    println("NO controller found");
    System.exit(-1);
  }
  arduino = new Arduino(this, Arduino.list()[0], 57600);

  //Initializes servo Motors
  arduino.pinMode(3, Arduino.SERVO);
  arduino.pinMode(9, Arduino.SERVO);
  arduino.pinMode(10, Arduino.SERVO);
  arduino.pinMode(11, Arduino.SERVO);
}
//Obtain user inputs from controller and return values to objects which use these user inputs.
public void getUserInput() {

  float yMove = controller.getSlider("yMove").getValue();
  float xMove = controller.getSlider("xMove").getValue();

  lThruster.getXY(xMove, yMove, false, true);
  rThruster.getXY(xMove, yMove, true, true);

  camCont.getYRight(controller.getSlider("camControl").getValue());
  TThruster.getUpDown( controller.getButton("up").pressed(), controller.getButton("down").pressed());
  lightObj.getAButten(controller.getButton("light").pressed());
}



void draw() {
  // Note: Allows servo pulses to be 1ms initially to avoid recalibration. 
  // That's why they are put in before the get input function getUserInput().
  arduino.digitalWrite(8, TThruster.controlDIR()); 
  
  arduino.digitalWrite(7, lThruster.sendThrustDIR()); //Control thruster direction (left)
  arduino.digitalWrite(12, rThruster.sendThrustDIR()); //Control thruster direction (right)
  delay(200);
  arduino.servoWrite(9, lThruster.thusterControl()); //Send left thruster servo signal to ESC based on the left thruster object
  arduino.servoWrite(11, rThruster.thusterControl());  //Send right thruster servo signal to ESC based on the right thruster object
  arduino.servoWrite(3, camCont.Control()); // Send servo pulse for camera control to servo motor
   arduino.servoWrite(10, TThruster.thurstUpDown()); 
  getUserInput();

  arduino.digitalWrite(2, lightObj.sendOnOffState()); //Control the light of the ROV
  
  
  
}
