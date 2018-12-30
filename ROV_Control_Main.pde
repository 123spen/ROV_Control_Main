import processing.serial.*;
import net.java.games.input.*;
import org.gamecontrolplus.*;
import org.gamecontrolplus.gui.*;
import cc.arduino.*;
import org.firmata.*;


ControlDevice controller;
ControlIO control;
Arduino arduino;

float camControl;
boolean down;
boolean up;
boolean light;

Thruster lThruster = new Thruster();
Thruster rThruster = new Thruster();

void setup() {
  size(360, 200);
  control = ControlIO.getInstance(this);
  controller = control.getMatchedDevice("ROVController");

  if (controller == null) {
    println("NO controller found");
    System.exit(-1);
  }
  // println(Arduino.list());
  arduino = new Arduino(this, Arduino.list()[0], 57600);
  arduino.pinMode(10, Arduino.SERVO);
  arduino.pinMode(11, Arduino.SERVO);
}

public void getUserInput() {
  float yMove = controller.getSlider("yMove").getValue();
  float xMove = controller.getSlider("xMove").getValue();
  
   lThruster.getXY(xMove, yMove, false, false);
   rThruster.getXY(xMove, yMove, true, false);
  
  camControl = map(controller.getSlider("camControl").getValue(), -1, 1, 0, 180);
  
  
  down  = controller.getButton("down").pressed();
  up  = controller.getButton("up").pressed();
  light = controller.getButton("light").pressed();
}

public void upDownControl(){
  
    if(down == true && up == false){
      arduino.digitalWrite(8, Arduino.HIGH);
      arduino.analogWrite(5, 127);
    }
    else if(down == false && up == true){
       arduino.digitalWrite(8, Arduino.LOW);
      arduino.analogWrite(5, 127);
    }
    else{
      arduino.analogWrite(5, Arduino.LOW);
    }

}

void draw() {
  
  arduino.servoWrite(10, lThruster.thusterControl());
  arduino.servoWrite(11, rThruster.thusterControl());
  
  getUserInput();
  
  arduino.digitalWrite(9, lThruster.sendThrustDIR());
  arduino.digitalWrite(12,   rThruster.sendThrustDIR());
  
  upDownControl();
  
}
