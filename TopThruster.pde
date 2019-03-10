import java.time.Duration; 
import java.time.Instant;



public class TopThruster {
  
  
  private boolean down; 
  private boolean up;  
  private int upDownDIR;
  private int lateState;
  private int sevrvo; 
  private boolean change;
  
  Instant startTop;
  Instant endTop; 
  Duration timeElapsedTop;

  private void TopThruster() {

    up = false;
    down = false;
    upDownDIR = 0;
    lateState = 0;
    sevrvo = 45;
    change = false;
    
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
      
     change = true; 
    }
    else if(timeElapsedTop.toMillis() > 200){
     lateState = upDownDIR;
     change = false;
    }
    else{
      
      change = false;
    }
    
   return change;
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
      sevrvo = 55;
    
    } else {
      sevrvo = 45;
    } 
    return sevrvo;
  }



}
