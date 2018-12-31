public class BellowControl {

  private boolean down;
  private boolean up;
  private int stepperDIR;


  private void BellowControl() {

    up = false;
    down = false;
    stepperDIR = 0;
  }

  public void getUpDown(boolean up, boolean down) {
    this.up = up;
    this.down = down;
  }

  public int controlDIR() {

    if (down == true && up == false) {
      stepperDIR = Arduino.HIGH;
    } else if (down == false && up == true) {
      stepperDIR = Arduino.LOW;
    }
    return stepperDIR;
  }


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
