import java.time.Duration;
import java.time.Instant;


public class Light {

  private int onOffState;
  private boolean pushState;
  private boolean pushStateFlip;


  Instant startLightCount;
  Instant endLightCount;
  Duration timeElapsedLightCount;

  public Light() {
    onOffState = 0;
    startLightCount = Instant.now();
    endLightCount = Instant.now();
    timeElapsedLightCount = Duration.between(startLightCount, endLightCount);
  }

  public void getAButten(boolean pushState) {
    this.pushState = pushState;
  }

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

  public int sendOnOffState() {
    setState();
    return  onOffState;
  }
}
