//This class is used to controls the bellows
public class BellowControl {

  private boolean down; //holds down input
  private boolean up;   //holds up input
  private int stepperDIR; //holds the pin value for the stepper driver DIR input pin

  //Constructor initialize the values for the variables in this class 
  private void BellowControl() {

    up = false;
    down = false;
    stepperDIR = 0;
  }

  //get up & down values for class
  public void getUpDown(boolean up, boolean down) {
    this.up = up;
    this.down = down;
  }

  //control if bellows are in opening or closing states
  public int controlDIR() {

    if (down == true && up == false) {
      stepperDIR = Arduino.HIGH;
    } else if (down == false && up == true) {
      stepperDIR = Arduino.LOW;
    }
    return stepperDIR;
  }

  //Send PWM signal if one bumper is pressed to stepper driver
  public int controlPWM() {

    int pulsePWMVal; 

    if (down == true ^ up == true) {
      pulsePWMVal= 127;
    } else {
      pulsePWMVal= 0;
    }
    return pulsePWMVal;
  }
}
