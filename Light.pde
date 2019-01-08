import java.time.Duration;
import java.time.Instant;


public class Light {

  private int onOffState; //Gives pin value for light being on or off
  private boolean pushState; //If buttin is pushed
  private boolean pushStateFlip; //Helps indicat if onOffState should change

//creat timer objects
  Instant startLightCount;
  Instant endLightCount;
  Duration timeElapsedLightCount;
  
  //Constructor initialize the values for the variables & objects in this class 
  public Light() {
    onOffState = 0;
    startLightCount = Instant.now();
    endLightCount = Instant.now();
    timeElapsedLightCount = Duration.between(startLightCount, endLightCount);
  }
//gets the A butten input value for class
  public void getAButten(boolean pushState) {
    this.pushState = pushState;
  }
//uses debouns with timer and the push state to find if the light is on or off
  private void setState() {
    
    if (pushState && pushStateFlip) {
      startLightCount = Instant.now();
      onOffState ^= 1;
      pushStateFlip = false;
    } else {
      endLightCount = Instant.now();
      timeElapsedLightCount = Duration.between(startLightCount, endLightCount);
      if ((timeElapsedLightCount.toMillis() > 100)&& !pushState) {
        pushStateFlip = true;
      }
    }
  }
//returns on of state of light
  public int sendOnOffState() {
    setState();
    return  onOffState;
  }
}
