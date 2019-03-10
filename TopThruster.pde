import java.time.Duration; 
import java.time.Instant;



public class TopThruster {
  
  
  private boolean down; 
  private boolean up;  
  private int upDownDIR;
  private int lateState;
  private int sevrvo; 
  
  Instant startTop;
  Instant endTop; 
  Duration timeElapsedTop;

  private void TopThruster() {

    up = false;
    down = false;
    upDownDIR = 0;
    lateState = 0;
    sevrvo = 45;
    
    startTop = Instant.now();
    endTop = Instant.now();
    timeElapsedTop = Duration.between(startTop, endTop);

    
  }

  //get up & down values for class
  public void getUpDown(boolean up, boolean down) {
    this.up = up;
    this.down = down;
  }
  
  private boolean checkChangeState(){
   
    endTop = Instant.now();
     timeElapsedTop = Duration.between(startTop, endTop);
  
    
    if(upDownDIR == lateState ){
     startTop = Instant.now();
      
     return true; 
    }
    else if(timeElapsedTop.toMillis() > 200){
     lateState = upDownDIR;
     return false;
    }
    else{
      
      return false;
    }
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
   
  if (down == true ^ up == true) {
      sevrvo = 50;
    
    } else {
      sevrvo = 45;
    } 
    return sevrvo;
  }



}
