import processing.serial.*;
import net.java.games.input.*;
import org.gamecontrolplus.*;
import org.gamecontrolplus.gui.*;
import cc.arduino.*;
import org.firmata.*;
import Thruster;

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
  controller = control.getMatchedDevice("ROVContoller");

  if (controller == null) {
    println("NO controller found");
    System.exit(-1);
  }
  // println(Arduino.list());
  arduino = new Arduino(this, Arduino.list()[0], 57600);
  arduino.pinMode(10, Arduino.SERVO);
}

public void getUserInput() {
  float yMove = controller.getSlider("yMove").getValue();
  float xMove = controller.getSlider("xMove").getValue();
  
  lThruster.sliderVal = yMove - xMove / 2;
   rThruster.sliderVal = yMove + xMove / 2;
  
  camControl = map(controller.getSlider("camControl").getValue(), -1, 1, 0, 180);
  
  
  down  = controller.getButton("down").pressed();
  up  = controller.getButton("up").pressed();
  light = controller.getButton("light").pressed();
}

public void upDownControl(){
  
    if(down == true && up == false){
      arduino.digitalWrite(8, Arduino.HIGH);
      arduino.analogWrite(9, 127);
    }
    else if(down == false && up == true){
       arduino.digitalWrite(8, Arduino.LOW);
      arduino.analogWrite(9, 127);
    }
    else{
      arduino.analogWrite(9, Arduino.LOW);
    }

}

void draw() {
  getUserInput();
  upDownControl();
  arduino.servoWrite(10, lThruster.thusterControl());
  arduino.servoWrite(11, rThruster.thusterControl());
}
