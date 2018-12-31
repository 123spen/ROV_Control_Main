import processing.serial.*;
import net.java.games.input.*;
import org.gamecontrolplus.*;
import org.gamecontrolplus.gui.*;
import cc.arduino.*;
import org.firmata.*;


ControlDevice controller;
ControlIO control;
Arduino arduino;


Thruster lThruster = new Thruster();
Thruster rThruster = new Thruster();
Light lightObj = new Light(); 
CamControl camCont = new CamControl();
BellowControl bellows = new BellowControl();

void setup() {
  size(360, 200);
  control = ControlIO.getInstance(this);
  controller = control.getMatchedDevice("ROVController");

  if (controller == null) {
    println("NO controller found");
    System.exit(-1);
  }
  arduino = new Arduino(this, Arduino.list()[0], 57600);
  arduino.pinMode(3, Arduino.SERVO);
  arduino.pinMode(10, Arduino.SERVO);
  arduino.pinMode(11, Arduino.SERVO);
}

public void getUserInput() {
  
  float yMove = controller.getSlider("yMove").getValue();
  float xMove = controller.getSlider("xMove").getValue();

  lThruster.getXY(xMove, yMove, false, false);
  rThruster.getXY(xMove, yMove, true, false);

  camCont.getYRight(controller.getSlider("camControl").getValue());
  bellows.getUpDown( controller.getButton("up").pressed(), controller.getButton("down").pressed());
  lightObj.getAButten(controller.getButton("light").pressed());
}



void draw() {

  arduino.servoWrite(10, lThruster.thusterControl());
  arduino.servoWrite(11, rThruster.thusterControl());
  arduino.servoWrite(3, camCont.Control());
  getUserInput();

  arduino.digitalWrite(9, lThruster.sendThrustDIR());
  arduino.digitalWrite(12, rThruster.sendThrustDIR());
  arduino.digitalWrite(7, lightObj.sendOnOffState());
  arduino.analogWrite(5, bellows.controlPWM());
  arduino.digitalWrite(4, bellows.controlDIR());
  
}
