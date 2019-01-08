import java.time.Duration;  //<>//
import java.time.Instant;

public class Thruster {

  private float x;
  private float y;
  private int thrustDir;
  private int thrustDirPastActive;
  private boolean DirTansState;
  Instant start;
  Instant end; 
  Duration timeElapsed;
//Constructor initialize the values for the variables in this class 
  private  Thruster() {
    x = 0;
    y = 0;
  }
  //
  private boolean timeDirSwitch() {

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

      if (timeElapsed.toMillis() > 500) {
        DirTansState = false;
        thrustDirPastActive = thrustDir;
        return true;
      } else {
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

    float posBaseXY = x/2 + y ;
    int sevrvo;


    if (posBaseXY < 0) {
      thrustDir = Arduino.HIGH;
    } else {
      thrustDir = Arduino.LOW;
    }

    if (timeDirSwitch()) {

      if (posBaseXY < 0) {
        sevrvo = (int) map(posBaseXY, 0, -1, 40, 50);
      } else {
        sevrvo = (int) map(posBaseXY, 0, 1, 40, 50);
      }
    } else {
      sevrvo = 40;
    }
    return sevrvo;
  }
  public int sendThrustDIR() {
    return thrustDir;
  }
}
