import java.time.Duration;  //<>//
import java.time.Instant;

public class Thruster {

  private float x;
  private float y;
  private int thrustDir;
  private int thrustDirPastActive;
  private boolean DirTansState;
  private boolean swithIdleState;
private int num1 = 1;

  Instant start;
  Instant end; 
  Duration timeElapsed;

  Instant startIdle;
  Instant endIdle; 
  Duration timeElapsedIdle;

  //Constructor initialize the values for the variables in this class 
  private  Thruster() {
    x = 0;
    y = 0;
    swithIdleState = false;
  }
  //
  private boolean timeDirSwitch(float posBase) {
if(idleTime(posBase) == true){
  thrustDirPastActive = thrustDir; 
}
    if (thrustDir == thrustDirPastActive) {

      DirTansState = false; 
      return true;
    } else if (DirTansState == false) {

      DirTansState = true;
      start = Instant.now();
      return false;
    } else {

      end = Instant.now();
      timeElapsed = Duration.between(start, end);

      if (timeElapsed.toMillis() > 200) {
        DirTansState = false;
        thrustDirPastActive = thrustDir;
        return true;
      } else {
        return false;
      }
    }
  }
  private boolean idleTime(float posBase) {

    posBase = round(10*posBase)/10;

    if (swithIdleState == false && posBase == 0) {

      startIdle = Instant.now();
      swithIdleState = true;
      return false;
    } else {

      if (posBase == 0) {
        
        endIdle = Instant.now();
        timeElapsedIdle = Duration.between(startIdle, endIdle);
         
        if (timeElapsedIdle.toMillis() > 200) {
          return true;
        } else {
          return false;
        }
      } else {
        swithIdleState = false;
        return false;
      }
    }
  }

  public void getXY(float x, float y, boolean invertX, boolean invertY) {
    if (invertX) {
      this.x = -x;
    } else {
      this.x = x;
    }
    if (invertY) {
      this.y = -y;
    } else {
      this.y = y;
    }
  }

  public int thusterControl() {

    float posBaseXY = 3*x/5 + y ;
    int sevrvo;


    if (posBaseXY < 0) {
      thrustDir = Arduino.HIGH;
    } else {
      thrustDir = Arduino.LOW;
    }

    if (timeDirSwitch(posBaseXY)) {

      if (posBaseXY < 0) {
        sevrvo = (int) map(posBaseXY, 0, -1, 45, 55);
      } else {
        sevrvo = (int) map(posBaseXY, 0, 1, 45, 55);
      }
    } else {
      sevrvo = 45;
    }
    return sevrvo;
  }
  public int sendThrustDIR() {
    return thrustDir;
  }
}
