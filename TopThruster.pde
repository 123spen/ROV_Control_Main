import java.time.Duration; 
import java.time.Instant;

public class TopThruster {
  
  
  private boolean down; 
  private boolean up;  
  private int upDownDIR;

  private void TopThruster() {

    up = false;
    down = false;
    upDownDIR = 0;
  }

  //get up & down values for class
  public void getUpDown(boolean up, boolean down) {
    this.up = up;
    this.down = down;
  }
  
   public int controlDIR() {

    if (down == true && up == false) {
      upDownDIR = Arduino.HIGH;
    } else if (down == false && up == true) {
      upDownDIR = Arduino.LOW;
    }
    return upDownDIR;
  }
  
  public int thurstUpDown() {
    int sevrvo = 45;
    
  if (down == true ^ up == true) {
      sevrvo = 50;
    } else {
      sevrvo = 45;
    } 
    return sevrvo;
  }



}
